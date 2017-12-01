//
//  LoginViewController.swift
//  picnpick
//
//  Created by Nick Gorman (LCL) on 11/30/17.
//  Copyright © 2017 Loblaw Digital. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let label = UILabel()
    let username = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Your Name"
        
        view.addSubview(username)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        username.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        username.layer.borderColor = UIColor.gray.cgColor
        username.layer.borderWidth = 2
        username.layer.cornerRadius = 8
        username.font = UIFont.boldSystemFont(ofSize: 18)
        username.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let addButton = UIButton()
        view.addSubview(addButton)
        addButton.setTitle("Go!", for: .normal)
        addButton.backgroundColor = .blue
        addButton.setTitleColor(.white, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 10
        addButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        addButton.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 10).isActive = true
        addButton.addTarget(self, action: #selector(startApp), for: .touchUpInside)
    }
    
    @objc func startApp() {
        if let text = username.text {
            UserDefaults.setUsername(name: text)
            self.navigationController?.setViewControllers([OrdersViewController()], animated: true)
        } else {
            username.placeholder = "Enter Username"
        }
    }
}

extension UserDefaults {
    static func setUsername(name: String) {
        UserDefaults.standard.set(name, forKey: "Username")
        UserDefaults.standard.synchronize()
    }
    
    static func getUsername() -> String {
        if let name = UserDefaults.standard.string(forKey: "Username") {
            return name
        }
        return "Unknown"
    }
}
