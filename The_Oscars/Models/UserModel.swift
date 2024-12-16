//
//  UserModel.swift
//  The_Oscars
//
//  Created by eden on 12/16/24.
//

import Foundation

struct UserModel {
    let id: String
    let password: String
    let email: String
    let name: String
    let phone: String
    
    init(id: String, password: String, email: String, name: String, phone: String) {
        self.id = id
        self.password = password
        self.email = email
        self.name = name
        self.phone = phone
    }
}
