//
//  LoginViewController.swift
//  The_Oscars
//
//  Created by t2023-m0149 on 12/17/24.
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
    
    private func navigateToMyPage() {
        let myPageVC = MyPageViewController() // MyPageViewController는 미리 생성된 상태여야 합니다.
        myPageVC.modalPresentationStyle = .fullScreen
        present(myPageVC, animated: true, completion: nil)
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
                self.navigateToMyPage()
            })
        } else {
            showAlert(message: "아이디 또는 비밀번호가 잘못되었습니다.")
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignupViewController()
        present(signUpVC, animated: true, completion: nil)
    }
    
//    @objc private func findIdPasswordButtonTapped() {
//        print("아이디/비밀번호 찾기 버튼이 눌렸습니다.")
//    }
}
