//
//  OrdersViewController.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/30/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import UIKit
import OverlayKit

class OrdersViewController: UIViewController {
    
    let network = Networking.shared
    let tableView = UITableView()
    var items:[Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pic'n'Pick Orders"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(newOrder))
        
        Networking.shared.socket?.on("newOrder") { data, ack in
            self.loadAllOrders()
        }
        
        Networking.shared.socket?.on("newItems") { data, ack in
            self.loadAllOrders()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllOrders()
    }
    
    @objc func newOrder() {
        Networking.makeNewOrder(userGroup: 1) { (newOrder) in
            self.loadAllOrders()
        }
    }
    
    func loadAllOrders() {
        Networking.getAllOrders(userGroup: 1, completion: { (orders) in
            
            self.items = orders
            self.tableView.reloadData()
        })
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.setup(order: items[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = TableViewController()
        table.order = items[indexPath.row]
        self.navigationController?.pushViewController(table, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

