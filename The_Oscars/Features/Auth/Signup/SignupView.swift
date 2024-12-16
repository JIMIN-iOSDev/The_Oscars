//
//  SignupView.swift
//  The_Oscars
//
//  Created by eden on 12/16/24.
//

import Foundation
import UIKit
import SnapKit

class SignupView: UIView {
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private let idField = CustomTextField(title: "아이디", placeholder: "아이디를 입력해 주세요")
    private let passwordField = CustomTextField(title: "비밀번호", placeholder: "비밀번호를 입력해 주세요")
    private let passwordConfirmField = CustomTextField(title: "비밀번호 확인", placeholder: "비밀번호를 다시 입력해 주세요")
    private let emailField = CustomTextField(title: "이메일 주소", placeholder: "이메일 주소를 입력해 주세요")
    private let nameField = CustomTextField(title: "이름", placeholder: "이메일 주소를 입력해 주세요")
    private let phoneField = CustomTextField(title: "휴대폰", placeholder: "이메일 주소를 입력해 주세요")
    
    // MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(idField)
        addSubview(passwordField)
        addSubview(passwordConfirmField)
        addSubview(emailField)
        addSubview(nameField)
        addSubview(phoneField)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        idField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(idField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        passwordConfirmField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        emailField.snp.makeConstraints{ make in
            make.top.equalTo(passwordConfirmField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        nameField.snp.makeConstraints{ make in
            make.top.equalTo(emailField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        phoneField.snp.makeConstraints{ make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
