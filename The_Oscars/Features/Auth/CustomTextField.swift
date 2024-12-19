//
//  CustomTextField.swift
//  The_Oscars
//
//  Created by eden on 12/15/24.
//

import UIKit
import SnapKit

class CustomTextField: UIView, UITextFieldDelegate {
    var fieldType: FieldType?
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let errorLabel = UILabel()
    private let bottomBorder = UIView()
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    // MARK: - 초기화
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        setupUI(title: title, placeholder: placeholder)
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI(title: String, placeholder: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .black
        
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.textColor = .black
        
        bottomBorder.backgroundColor = .gray
        
        errorLabel.font = UIFont.systemFont(ofSize: 8)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        addSubviews(
            titleLabel,
            textField,
            bottomBorder,
            errorLabel
        )
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        bottomBorder.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomBorder.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        
        self.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    func setErrorMessage(_ message: String?) {
        if let message = message {
            errorLabel.text = message
            errorLabel.isHidden = false
            bottomBorder.backgroundColor = .red
        } else {
            errorLabel.text = nil
            errorLabel.isHidden = true
            bottomBorder.backgroundColor = .gray
        }
    }
    
    // MARK: - UITextFieldDelegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomBorder.backgroundColor = UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fieldType = self.fieldType else { return }
        let validator = Validator()
        
        let referenceText = fieldType == .passwordConfirm ?
            (self.superview as? SignupView)?.passwordField.text : nil
        
        let (isValid, errorMessage) = validator.validateFields(fieldType: fieldType, text: textField.text, referenceText: referenceText)
        
        if isValid {
            setErrorMessage(nil)
            bottomBorder.backgroundColor = .gray
        } else {
            setErrorMessage(errorMessage)
            bottomBorder.backgroundColor = .red
        }
    }
}
