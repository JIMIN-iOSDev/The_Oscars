//
//  SignupViewController.swift
//  The_Oscars
//
//  Created by eden on 12/15/24.
//

import Foundation
import UIKit
import SnapKit

class SignupViewController: UIViewController {
    // MARK: - UI Components
    private let signupView = SignupView()
    
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
        // let loginViewController = LoginViewController()
        // navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
