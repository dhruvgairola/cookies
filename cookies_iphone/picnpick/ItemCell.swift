//
//  ItemCell.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 12/1/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    
    let orderImage = UIImageView()
    let titleLabel = UILabel()
    let checkmark = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(orderImage)
        orderImage.translatesAutoresizingMaskIntoConstraints = false
        orderImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        orderImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        orderImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        orderImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        orderImage.contentMode = .scaleAspectFill
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.backgroundColor = .white
        
        addSubview(checkmark)
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        checkmark.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        checkmark.widthAnchor.constraint(equalToConstant: 40).isActive = true
        checkmark.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        checkmark.image = UIImage(named: "checkmark")
        self.clipsToBounds = true
    }
    
    func setup(item: Item) {
        if let img = item.image, let decodedData = Data(base64Encoded: img, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            orderImage.image = image
        }
        if item.is_removed == true {
            checkmark.isHidden = false
        } else {
            checkmark.isHidden = true
        }
        titleLabel.text = "\(item.item_name)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
