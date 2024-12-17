//
//  UserDefaultManager.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let defaults = UserDefaults.standard
    private let userKey = "users"
    
    private init() {}
    
    func signupUser(_ user: UserModel) -> Bool {
        var users: [UserModel] = []
        
        if let data = defaults.data(forKey: userKey),
           let loadedUsers = try? JSONDecoder().decode([UserModel].self, from: data) {
            users = loadedUsers
        }
        
        users.append(user)
        if let encoded = try? JSONEncoder().encode(users) {
            defaults.set(encoded, forKey: userKey)
            return true
        }
        return false
    }
}
