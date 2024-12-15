//
//  CustomTextField.swift
//  The_Oscars
//
//  Created by eden on 12/15/24.
//

import UIKit
import SnapKit

class CustomTextField: UIView {
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let errorLabel = UILabel()
    private let bottomBorder = UIView()
    private let button = UIButton()
    
    // MARK: - 초기화
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        setupUI(title: title, placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI(title: String, placeholder: String) {
        titleLabel.text = "제목"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .lightGray
        
        textField.placeholder = "제목을 입력해주세요"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 12)
        
        bottomBorder.backgroundColor = .gray
        
        errorLabel.font = UIFont.systemFont(ofSize: 8)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(bottomBorder)
        addSubview(errorLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        bottomBorder.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomBorder.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
