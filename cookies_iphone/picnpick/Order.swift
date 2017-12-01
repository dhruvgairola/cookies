//
//  Order.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/30/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class Order: Mappable {
    
    var order_id: Int = 0
    var user_group_id: Int = 0
    var order_details:[Item] = []
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        order_id            <- map["orderId"]
        user_group_id       <- map["userGroupId"]
        order_details       <- map["orderDetails"]
        
    }
}

class Item: Mappable {
    
    var image: String?
    var item_name: String = ""
    var order_id: Int = 0
    var order_detail_id: Int = 0
    var is_removed: Bool = false
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        item_name           <- map["itemName"]
        order_id           <- map["orderId"]
        image              <- map["image"]
        order_detail_id     <- map["orderDetailId"]
        is_removed          <- map["isRemoved"]
    }
}
