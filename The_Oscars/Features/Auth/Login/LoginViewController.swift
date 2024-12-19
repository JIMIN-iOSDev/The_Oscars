//
//  LoginViewController.swift
//  The_Oscars
//
//  Created by t2023-m0149 on 12/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        saveTemporaryUser()
    }
    
    func saveTemporaryUser() {
        let tempUser = UserModel(
            id: "testuser",
            password: "password123",
            email: "testuser@example.com",
            name: "임시 사용자",
            phone: "010-0000-0000"
        )

        let signupSuccess = UserDefaultsManager.shared.signupUser(tempUser)

        if signupSuccess {
            print("임시 사용자 생성 성공")
        } else {
            print("임시 사용자 생성 실패")
        }
    }
    
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginView.findIdPasswordButton.addTarget(self, action: #selector(findIdPasswordButtonTapped), for: .touchUpInside)
    }
    
    private func navigateToTabBar() {
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        guard let id = loginView.idTextField.text, !id.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "아이디와 비밀번호를 입력해주세요.")
            return
        }
        
        let success = UserDefaultsManager.shared.loginUser(id: id, password: password)
        
        if success {
            showAlert(message: "로그인 성공!", completion: {
                self.navigateToTabBar()
            })
        } else {
            showAlert(message: "아이디 또는 비밀번호가 잘못되었습니다.")
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignupViewController()
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func findIdPasswordButtonTapped() {
        print("아이디/비밀번호 찾기 버튼이 눌렸습니다.")
    }
}
