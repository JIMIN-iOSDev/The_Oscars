//
//  SignupViewController.swift
//  The_Oscars
//
//  Created by eden on 12/15/24.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
    private let signupView = SignupView()
    private let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupActions()
    }
    
    // MARK: - UI 설정
    private func setupLayout() {
        view.addSubview(signupView)
        
        signupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        signupView.loginNavgationButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        signupView.checkIdButton.addTarget(self, action: #selector(checkIdAvailability), for: .touchUpInside)
        signupView.signupButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc
    private func checkIdAvailability() {
        guard let id = signupView.idField.text, !id.isEmpty else {
            showAlert(message: "아이디를 입력해 주세요.")
            return
        }
        
        if UserDefaultsManager.shared.isUserIdDuplicated(id) {
            showAlert(message: "이미 존재하는 아이디입니다.")
        } else {
            showAlert(message: "사용 가능한 아이디입니다.")
        }
    }
    
    @objc
    private func navigateToLogin() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc
    private func signup() {
        var isValid = true

        let idValidation = validator.validateFields(fieldType: .id, text: signupView.idField.text)
        if !idValidation.0 {
            signupView.idField.setErrorMessage(idValidation.1)
            isValid = false
        } else {
            signupView.idField.setErrorMessage(nil)
        }

        let passwordValidation = validator.validateFields(fieldType: .password, text: signupView.passwordField.text)
        if !passwordValidation.0 {
            signupView.passwordField.setErrorMessage(passwordValidation.1)
            isValid = false
        } else {
            signupView.passwordField.setErrorMessage(nil)
        }

        let passwordConfirmValidation = validator.validateFields(
            fieldType: .passwordConfirm,
            text: signupView.passwordConfirmField.text,
            referenceText: signupView.passwordField.text
        )
        if !passwordConfirmValidation.0 {
            signupView.passwordConfirmField.setErrorMessage(passwordConfirmValidation.1)
            isValid = false
        } else {
            signupView.passwordConfirmField.setErrorMessage(nil)
        }

        let emailValidation = validator.validateFields(fieldType: .email, text: signupView.emailField.text)
        if !emailValidation.0 {
            signupView.emailField.setErrorMessage(emailValidation.1)
            isValid = false
        } else {
            signupView.emailField.setErrorMessage(nil)
        }

        let nameValidation = validator.validateFields(fieldType: .name, text: signupView.nameField.text)
        if !nameValidation.0 {
            signupView.nameField.setErrorMessage(nameValidation.1)
            isValid = false
        } else {
            signupView.nameField.setErrorMessage(nil)
        }

        let phoneValidation = validator.validateFields(fieldType: .phoneNumber, text: signupView.phoneField.text)
        if !phoneValidation.0 {
            signupView.phoneField.setErrorMessage(phoneValidation.1)
            isValid = false
        } else {
            signupView.phoneField.setErrorMessage(nil)
        }

        if isValid {
            let user = UserModel(
                id: signupView.idField.text!,
                password: signupView.passwordField.text!,
                email: signupView.emailField.text!,
                name: signupView.nameField.text!,
                phone: signupView.phoneField.text!
            )
            
            if UserDefaultsManager.shared.signupUser(user) {
                showAlert(message: "회원가입 성공!")
            } else {
                showAlert(message: "회원가입 중 문제가 발생했습니다. 다시 시도해주세요.")
            }
        } else {
            showAlert(message: "입력 정보를 다시 확인해 주세요.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
