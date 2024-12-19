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
        setupUserInfo()
        displayBookings()
        saveTemporaryBooking()
    }
    
    
    private func setupMyPageView() {
        view.addSubview(myPageView)
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupUserInfo() {
         if let user = UserDefaultsManager.shared.getLoggedInUser() {
             myPageView.userNameLabel.text = "\(user.name)님"
             myPageView.userIdLabel.text = "아이디: \(user.id)"
             myPageView.userEmailLabel.text = "이메일: \(user.email)"
             myPageView.logoutButton.isHidden = false
         }
     }
    
    private func setupActions() {
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageView.homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        myPageView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        showLogoutConfirmation()
    }
    
    private func showLogoutConfirmation() {
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        // "예" 버튼: 로그아웃 후 로그인 페이지로 이동
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { _ in
            self.logoutAndNavigateToLogin()
        }))
        
        // "아니오" 버튼: 마이페이지에 남아있음
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func logoutAndNavigateToLogin() {
        // 로그아웃 처리
        UserDefaultsManager.shared.logoutUser()
        
        // 로그인 페이지로 이동
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    private func displayBookings() {
        let bookings = UserDefaultsManager.shared.getBookings()
        
        if bookings.isEmpty {
            myPageView.bookingHistoryTitleLabel.text = "예매 내역이 없습니다."
            return
        }
        
        // 예매된 첫 번째 영화 정보를 표시 (예제)
        if let booking = bookings.first {
            myPageView.movieTitleLabel.text = booking.movieName
            myPageView.movieTimeTextLabel.text = "날짜: \(booking.date)"
            myPageView.movieTimeLabel.text = "시간: \(booking.time)"
            myPageView.ticketCountLabel.text = "인원: \(booking.peopleCount)명"
        }
    }
    
    func saveTemporaryBooking() {
        let tempBooking = Booking(
            movieName: "임시 영화",
            date: "2024-12-25",
            time: "19:00",
            peopleCount: 2,
            totalPrice: 20000
        )

        UserDefaultsManager.shared.saveBooking(tempBooking)
        print("임시 예매 정보 저장 성공")
    }
    
    
    @objc private func homeButtonTapped() {
        let tabBarVC = TabBarViewController()
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
    }
    
    @objc private func menuButtonTapped() {
        print("메뉴 버튼이 눌렸습니다.")
    }
}
