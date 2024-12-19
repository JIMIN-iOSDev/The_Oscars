//
//  Validator.swift
//  The_Oscars
//
//  Created by eden on 12/19/24.
//

import Foundation

import UIKit

enum FieldType: String {
    case id = "아이디"
    case password = "비밀번호"
    case passwordConfirm = "비밀번호 확인"
    case email = "이메일"
    case name = "이름"
    case phoneNumber = "휴대폰 번호"
}

struct Validator {
    func validateFields(fieldType: FieldType, text: String?, referenceText: String? = nil) -> (Bool, String?) {
        guard let text = text, !text.isEmpty else {
            return (false, "\(fieldType.rawValue)를 입력해 주세요.")
        }
        
        switch fieldType {
        case .id:
            if !isValidUserId(text) {
                return (false, "아이디는 영어와 숫자 조합이어야 합니다.")
            }
        case .password:
            if !isValidPassword(text) {
                return (false, "비밀번호는 영어, 숫자, 특수문자 포함 8자 이상이어야 합니다.")
            }
        case .passwordConfirm:
            guard let referenceText = referenceText else {
                return (false, "비밀번호를 먼저 입력해 주세요.")
            }
            if text != referenceText {
                return (false, "비밀번호가 일치하지 않습니다.")
            }
        case .email:
            if !isValidEmail(text) {
                return (false, "유효한 이메일 주소를 입력해 주세요.")
            }
        case .name:
            if text.count > 16 {
                return (false, "이름은 최대 16바이트까지 입력 가능합니다.")
            }
        case .phoneNumber:
            if !isValidPhoneNumber(text) {
                return (false, "휴대폰 번호는 '010'으로 시작하는 숫자 11자리여야 합니다.")
            }
        }
        
        return (true, nil)
    }
    
    private func isValidUserId(_ id: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{1,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: id)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
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
