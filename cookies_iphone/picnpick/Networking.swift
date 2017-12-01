//
//  Networking.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/29/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SocketIO

class Networking {

    static var shared = Networking()
    let manager = SocketManager(socketURL: URL(string:"http://54.159.150.45:3000/")!)
    var socket:SocketIOClient?
    
    static func makeNewOrder(userGroup: Int, completion: @escaping (Order?)->()) {
        let parameters: Parameters = [
            "userGroupId": 1,
            "username": UserDefaults.getUsername()
        ]
        
        Alamofire.request("http://54.159.150.45:8080/cookies/addOrder",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            if let json = response.result.value as? [String:Any] {
                                let order = Order(JSON: json)
                                completion(order)
                            } else {
                                completion(nil)
                            }
        }
    }
    
    static func removeItemFromOrder(orderId: String, orderDetailId: String, completion: @escaping (Bool)->()) {
        guard let a = Int(orderDetailId) else { return }
            
        let parameters: Parameters = [
            "isRemoved": 1,
            "orderDetailId": a
        ]
        
        Alamofire.request("http://54.159.150.45:8080/cookies/toggleOrderDetailRemoved",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                    completion(true)
        }
    }
    
    static func getAllOrders(userGroup: Int, completion: @escaping ([Order])->()) {
        let parameters: Parameters = [
            "userGroupId": userGroup
        ]
        
        Alamofire.request("http://54.159.150.45:8080/cookies/getOrders",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).responseJSON { (response) in
            if let json = response.result.value as? [[String:Any]] {
                let orders = Mapper<Order>().mapArray(JSONArray: json)
                completion(orders)
            } else {
                completion([])
            }
        }
    }
    
    static func getOrder(orderId: String, completion: @escaping (Order?)->()) {
        let parameters: Parameters = [
            "orderId": orderId
        ]
        
        Alamofire.request("http://54.159.150.45:8080/cookies/getOrder",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            if let json = response.result.value as? [String:Any] {
                                let order = Order(JSON: json)
                                completion(order)
                            } else {
                                completion(nil)
                            }
        }
    }
    
    static func getImageMetaData(image: UIImage, completion: @escaping (String)->()) {
        if let imgData = UIImageJPEGRepresentation(image, 0.2) {
            let strBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
            
            let parameters: Parameters = [
                "image": strBase64
            ]
            
            Alamofire.request("http://54.159.150.45:3001/getImageMetadata",
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default).response { (response) in
                                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8) {
                                    completion(str)
                                } else {
                                    completion("")
                                }
            }
        }
    }
    
    static func addImageToOrder(image: UIImage, orderId: String, productName: String, completion: @escaping (Bool)->()) {
        if let imgData = UIImageJPEGRepresentation(image, 0.2) {
            
            let strBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
            let parameters: Parameters = [
                "userId":1,
                "image": strBase64,
                "order": ["orderId":orderId],
                "userName": UserDefaults.getUsername(),
                "itemName": productName
            ]
            let _url = "http://54.159.150.45:8080/cookies/addOrderDetail"
        
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            
            let url = URL(string: _url)!
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(false)
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    completion(true)
                    print(responseJSON)
                }
            }
            task.resume()
        }
    }
    
    func startSocket() {
        socket = manager.defaultSocket
        socket?.on("newItems") { data, ack in
            print(data)
        }
        socket?.on("newItems", callback: { (data, ack) in
            print(data)
        })
        
        
        socket?.connect()
    }
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
