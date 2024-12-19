//
//  MyPageViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation
import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    let myPageView = MyPageView()
    
    //    override func loadView() {
    //        view = myPageView
    //    }
    //    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        view.backgroundColor = .white
        setupMyPageView()
    }
    private func setupMyPageView() {
        view.addSubview(myPageView)
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageView.homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        myPageView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        print("로그아웃 버튼이 눌렸습니다.")
    }
    
    @objc private func homeButtonTapped() {
        print("홈 버튼이 눌렸습니다.")
    }
    
    @objc private func menuButtonTapped() {
        print("메뉴 버튼이 눌렸습니다.")
    }
}
