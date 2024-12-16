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
    private let nameField = CustomTextField(title: "이름", placeholder: "OSCARS에서 사용할 이름을 입력해 주세요")
    private let phoneField = CustomTextField(title: "전화번호", placeholder: "번호를 '-' 제외하고 입력해 주세요")
    private let loginNavgationLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 회원이시신요?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    private let loginNavgationButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 하러 가기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return button
    }()
    private let loginNavgationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입 하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0)
        return button
    }()
    
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
        addSubview(signupButton)
        addSubview(loginNavgationStackView)
        
        loginNavgationStackView.addArrangedSubview(loginNavgationLabel)
        loginNavgationStackView.addArrangedSubview(loginNavgationButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        idField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(idField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordConfirmField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailField.snp.makeConstraints{ make in
            make.top.equalTo(passwordConfirmField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nameField.snp.makeConstraints{ make in
            make.top.equalTo(emailField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            
        }
        
        phoneField.snp.makeConstraints{ make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginNavgationStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
}
