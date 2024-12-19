//
//  LoginView.swift
//  The_Oscars
//
//  Created by t2023-m0149 on 12/17/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    let titleLabel = UILabel()
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)
    let findIdPasswordButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayout()
    }
    
    
    private func setupViews() {
        backgroundColor = .white
        
        // 타이틀 설정
        titleLabel.text = "OSCARS"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = UIColor.systemYellow
        titleLabel.textAlignment = .center
        
        // 아이디 입력 필드 설정
        setupTextField(idTextField, placeholder: "아이디")
        
        
        // 비밀번호 입력 필드 설정
        setupTextField(passwordTextField, placeholder: "비밀번호", isSecure: true)
        
        // 로그인 버튼 설정
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor.systemYellow
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 5
        
        // 회원가입 버튼 설정
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        // 아이디찾기/비밀번호찾기 버튼 설정
        findIdPasswordButton.setTitle("아이디찾기 비밀번호 찾기", for: .normal)
        findIdPasswordButton.setTitleColor(.black, for: .normal)
        findIdPasswordButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        // 뷰에 추가
        addSubview(titleLabel)
        addSubview(idTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signUpButton)
        addSubview(findIdPasswordButton)
    }
    
    
    private func setupLayout() {
        let padding: CGFloat = 20
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        findIdPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-padding)
        }
    }
    
    
    private func setupTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.backgroundColor = UIColor.clear
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.textColor = .black
    }
}
