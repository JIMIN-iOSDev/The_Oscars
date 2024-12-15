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
    
    // MARK: - 초기화
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        
    }
}
