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
    

}
