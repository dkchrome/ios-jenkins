//
//  User.swift
//  StockFeed
//
//  Created by Deepak Kumar on 12/04/21.
//

import Foundation

struct User {
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(with dict: [String: String]?) {
        name = dict?["name"] ?? ""
        email = dict?["email"] ?? ""
        password = dict?["password"] ?? ""
    }
}
