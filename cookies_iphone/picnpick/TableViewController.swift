//
//  TableViewController.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/29/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    let network = Networking.shared
    let tableView = UITableView()
    var order:Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pic'n'Pick Items"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(takePicture))
        
        Networking.shared.socket?.on("newItems") { data, ack in
            self.reloadOrder()
        }
    }
    
    @objc func removeItemFromOrder(itemDetailId: String) {
        guard let order = order else { return }
        Networking.removeItemFromOrder(orderId: "\(order.order_id)", orderDetailId: itemDetailId) { (success) in
            self.reloadOrder()
        }
    }
    
    @objc func takePicture() {
        present(TakePhotoViewController(), animated: true, completion: nil)
    }
    
    func processPhoto(image: UIImage) {
        Networking.getImageMetaData(image: image, completion: { (keywords) in
            let keyword = self.filterKeywords(words: keywords.lowercased())
            if let orderId = self.order?.order_id {
                Networking.addImageToOrder(image: image, orderId: "\(orderId)", productName: keyword, completion: { (success) in
                    self.reloadOrder()
                })
            }
        })
    }
    
    func filterKeywords(words: String) -> String {
        
        if words.contains("ginger") {
            return "Canada Dry GingerAle"
        } else if words.contains("oats") {
            return "Quaker Large Flake Oats"
        } else if words.contains("trail") {
            return "President's Choice Trail Mix"
        } else if words.contains("syrup") {
            return "President's Choice Maple Syrup"
        } else if words.contains("lapsang") {
            return "David's Tea - Black"
        } else if words.contains("blend") {
            return "Metropolitan Premium Coffee Blend"
        }
        return words
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadOrder()
    }
    
    func reloadOrder() {
        if let _order = order {
            Networking.getOrder(orderId: "\(_order.order_id)", completion: { (refreshedOrder) in
                if let refreshed = refreshedOrder {
                    self.order = refreshed
                    self.tableView.reloadData()
                }
            })
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        if let order = order {
            cell.setup(item: order.order_details[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let order = order else { return 0 }
        return order.order_details.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let order = order else { return }
        Networking.removeItemFromOrder(orderId: "", orderDetailId: "\(order.order_details[indexPath.row].order_detail_id)") { (success) in
            self.reloadOrder()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
