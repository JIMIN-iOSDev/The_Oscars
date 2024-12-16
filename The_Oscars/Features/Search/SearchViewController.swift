//
//  SearchViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

<<<<<<< HEAD
import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // 검색창
    private let searchTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .lightGray
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.attributedPlaceholder = NSAttributedString(string: "영화를 검색하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textfield
    }()
    
    // 뒤로가기 버튼
    private let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = ""
        return button
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
    
    // 임시 예매버튼
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(navigateToSearchScreen), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setNavigationBarHeight()
        configureNavigationBar()
        configureUI()
    }
    
    // 임시 네비게이션
    @objc func navigateToSearchScreen() {
        let detailVC = MovieDetailController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // 네비게이션 바 높이 조정
    private func setNavigationBarHeight() {
        
        if let navBar = navigationController?.navigationBar {
            var frame = navBar.frame
            frame.origin.y = 80
            navBar.frame = frame
        }
    }
    
    // 네비게이션 바 버튼 설정
    private func configureNavigationBar() {
        navigationItem.titleView = searchTextfield
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureUI() {

        [searchTextfield, recommendLabel, testButton]
            .forEach { view.addSubview($0) }
        
        searchTextfield.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextfield.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
    
}


#Preview {
    SearchViewController()
=======
import Foundation
import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
>>>>>>> develop
}
