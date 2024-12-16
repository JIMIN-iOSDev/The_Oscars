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
    }
    
    // MARK: - UI 설정
    private func setupLayout() {
        view.addSubview(signupView)
        
        signupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
