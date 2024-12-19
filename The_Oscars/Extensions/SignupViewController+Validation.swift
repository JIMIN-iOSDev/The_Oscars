//
//  SignupViewController+Validation.swift
//  The_Oscars
//
//  Created by eden on 12/19/24.
//

import UIKit

enum FieldType {
    case id
    case password
    case email
    case phone
    case none
}

struct Validator {
    func validateField(fieldType: FieldType, value: String?) -> (Bool, String) {
//        
//        if let id = id, !isValidId(id) {
//           return (false, "아이디는 영어와 숫자 조합이어야 합니다.")
//        }
//        if let password = password, !isValidPassword(password) {
//           return (false, "비밀번호는 영어, 숫자 포함 8자 이상이어야 합니다.")
//        }
//        if let email = email, !isValidEmail(email) {
//           return (false, "아이디는 영어와 숫자 조합이어야 합니다.")
//        }
//        if let phone = id, !isValidPhone(phone) {
//           return (false, "아이디는 영어와 숫자 조합이어야 합니다.")
//        }
        return (true, "123")
    }
    
    private func isValidId(_ id: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{1,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: id)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&#]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let regex = "^010\\d{8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phone)
    }
}
