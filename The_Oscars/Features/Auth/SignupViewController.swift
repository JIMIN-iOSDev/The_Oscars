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
    private let idField = CustomTextField(title: "아이디", placeholder: "아이디를 입력해 주세요")
    private let passwordField = CustomTextField(title: "비밀번호", placeholder: "비밀번호를 입력해 주세요")
    private let passwordConfirmField = CustomTextField(title: "비밀번호 확인", placeholder: "비밀번호를 다시 입력해 주세요")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(idField)
        view.addSubview(passwordField)
        view.addSubview(passwordConfirmField)
        
        idField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(idField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        passwordConfirmField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
    }
}
