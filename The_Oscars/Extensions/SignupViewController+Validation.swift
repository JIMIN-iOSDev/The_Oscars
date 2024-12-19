//
//  SignupViewController+Validation.swift
//  The_Oscars
//
//  Created by eden on 12/19/24.
//

import UIKit

extension SignupViewController {
    func validateFields() -> Bool {
        var isValid = true
        
        return isValid
    }
    
    private func isValidUserId(_ id: String) -> Bool {
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
    
    private func isValidPhoneNumber(_ phone: String) -> Bool {
        let regex = "^010\\d{8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phone)
    }
}
