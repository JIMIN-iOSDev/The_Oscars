//
//  UserDefaultManager.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private let userKey = "users"
    
    private init() {}
    
    // 회원가입
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
    
    // 아이디 중복 체크
    func isUserIdDuplicated(_ id: String) -> Bool {
        if let data = defaults.data(forKey: userKey),
           let users = try? JSONDecoder().decode([UserModel].self, from: data) {
            return users.contains(where: { $0.id == id })
        }
        return false
    }
}
