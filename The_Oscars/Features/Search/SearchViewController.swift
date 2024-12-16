//
//  SearchViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // 검색창
    private let searchTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .lightGray
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.attributedPlaceholder = NSAttributedString(string: "영화 제목을 검색하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textfield
    }()
    
    // 추천 글씨
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 영화"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        searchTextfield.delegate = self
        searchTextfield.becomeFirstResponder()
        
        configureUI()
    }
    
    private func configureUI() {

        [searchTextfield, recommendLabel]
            .forEach { view.addSubview($0) }
        
        searchTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(50)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextfield.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    // 엔터 키 누르면 키보드 사라지고 검색이 가능
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchQuery = textField.text, !searchQuery.isEmpty {
            print("검색할 영화: \(searchQuery)")
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
}

