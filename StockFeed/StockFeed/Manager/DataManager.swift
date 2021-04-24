//
//  DataManager.swift
//  StockFeed
//
//  Created by Deepak Kumar on 19/04/21.
//

import Foundation

class DataManager: NSObject {
    static var shared = DataManager()
    
    private override init() {
        
    }
    
    func saveUser(user: User) {
        let dict: [String: String] = ["name": user.name,
                                      "email": user.email,
                                      "password": user.password]
        
        UserDefaults.standard.set(dict, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    func getUser() -> User? {
        if let userDict = UserDefaults.standard.object(forKey: "user") as? [String: String] {
            let user = User(with: userDict)
            return user
        }
        
        return nil
    }
    
    func removeUser() {
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    func saveUserLoggedIn() {
        UserDefaults.standard.set("1", forKey: "login")
        UserDefaults.standard.synchronize()
    }
    
    func isUserLoggedIn() -> Bool {
        if let login = UserDefaults.standard.object(forKey: "login") {
            return true
        }
        return false
    }
    
    func remveUserLoggedIn() {
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.synchronize()
    }
}

extension UserDefaults {
    func clear() {
        guard let domainName = Bundle.main.bundleIdentifier else {
            return
        }
        removePersistentDomain(forName: domainName)
        synchronize()
    }
}
