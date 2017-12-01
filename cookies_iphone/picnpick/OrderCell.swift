//
//  OrderCell.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 12/1/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import UIKit

class OrderCell: UITableViewCell {
    
    let orderImage = UIImageView()
    let titleLabel = UILabel()
    let orderNum = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(orderImage)
        orderImage.translatesAutoresizingMaskIntoConstraints = false
        orderImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        orderImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        orderImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        orderImage.widthAnchor.constraint(equalTo: orderImage.heightAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: orderImage.trailingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(orderNum)
        orderNum.translatesAutoresizingMaskIntoConstraints = false
        orderNum.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        orderNum.topAnchor.constraint(equalTo: topAnchor).isActive = true
        orderNum.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        orderNum.widthAnchor.constraint(equalToConstant: 80).isActive = true
        orderNum.textAlignment = .right
    }
    
    func setup(order: Order) {
        orderImage.image = UIImage(named: "bag")
        titleLabel.text = "Order #\(order.order_id)"
        orderNum.text = "Items: \(order.order_details.count)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
