//
//  LoginViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginView.findIdPasswordButton.addTarget(self, action: #selector(findIdPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        print("로그인 버튼이 눌렸습니다.")
    }
    
    @objc private func signUpButtonTapped() {
        print("회원가입 버튼이 눌렸습니다.")
    }
    
    @objc private func findIdPasswordButtonTapped() {
        print("아이디/비밀번호 찾기 버튼이 눌렸습니다.")
    }
}
