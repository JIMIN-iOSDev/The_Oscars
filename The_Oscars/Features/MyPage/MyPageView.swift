//
//  MyPageView.swift
//  The_Oscars
//
//  Created by t2023-m0149 on 12/17/24.
//

import UIKit
import SnapKit

class MyPageView: UIView {
    
    
    // 헤더
    let headerView = UIView()
    let gradientLayer = CAGradientLayer()
    let myPageLabel = UILabel()
    let userNameLabel = UILabel()
    let userIdLabel = UILabel()
    let userEmailLabel = UILabel()
    let logoutButton = UIButton(type: .system)
    let menuButton = UIButton(type: .system)
    let homeButton = UIButton(type: .system)
    
    // 예매 내역
    let bookingHistoryTitleLabel = UILabel()
    let bookingContainerView = UIView()
    let bookingStackView = UIStackView()
    let posterImageView = UIImageView()
    let movieTitleLabel = UILabel()
    let movieInfoStackView = UIStackView()
    let theaterNameLabel = UILabel()
    let movieDateLabel = UILabel()
    let movieTimeLabel = UILabel()
    let ticketCountLabel = UILabel()
    
    // Footer
    let oscarsLabel = UILabel()
//    let footerTextStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = headerView.bounds
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        // 헤더 그라데이션 설정
        gradientLayer.colors = [UIColor.systemYellow.cgColor, UIColor.systemYellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        headerView.layer.insertSublayer(gradientLayer, at: 0)
        
        // 헤더 정보
        myPageLabel.text = "마이 페이지"
        myPageLabel.font = .boldSystemFont(ofSize: 30)
        myPageLabel.textColor = .black
        myPageLabel.textAlignment = .center
        
        userNameLabel.text = ""
        userNameLabel.font = .boldSystemFont(ofSize: 26)
        userNameLabel.textColor = .black
        
        userIdLabel.text = ""
        userIdLabel.font = .systemFont(ofSize: 18)
        userIdLabel.textColor = .black
        
        userEmailLabel.text = ""
        userEmailLabel.font = .systemFont(ofSize: 18)
        userEmailLabel.textColor = .black
        
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 5
        
        menuButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuButton.tintColor = .black
        homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        homeButton.tintColor = .black
        
        
        // 예매 내역 타이틀
        bookingHistoryTitleLabel.text = "예매 내역"
        bookingHistoryTitleLabel.font = .boldSystemFont(ofSize: 30)
        bookingHistoryTitleLabel.textColor = .black
        
        // 예매 내역 컨테이너 뷰
        bookingContainerView.backgroundColor = .white
        bookingContainerView.layer.borderWidth = 1
        bookingContainerView.layer.borderColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1.0).cgColor
        bookingContainerView.layer.cornerRadius = 10
        
        // 예매 내역 스택뷰
        bookingStackView.axis = .horizontal
        bookingStackView.spacing = 20
        bookingStackView.alignment = .top
        bookingStackView.distribution = .fill
        
        posterImageView.backgroundColor = .lightGray
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
        
        movieTitleLabel.text = ""
        movieTitleLabel.font = .boldSystemFont(ofSize: 30)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .black
        
        movieInfoStackView.axis = .vertical
        movieInfoStackView.spacing = 40
        movieInfoStackView.alignment = .fill
        movieInfoStackView.distribution = .fill
        
        theaterNameLabel.text = "스파르타 상영관"
        theaterNameLabel.font = .boldSystemFont(ofSize: 16)
        theaterNameLabel.textColor = .black
        
        movieDateLabel.text = ""
        movieDateLabel.font = .boldSystemFont(ofSize: 16)
        movieDateLabel.textColor = .black
        movieDateLabel.numberOfLines = 0
        movieDateLabel.lineBreakMode = .byWordWrapping

        
        movieTimeLabel.text = ""
        movieTimeLabel.font = .boldSystemFont(ofSize: 16)
        movieTimeLabel.textColor = .black
        movieTimeLabel.numberOfLines = 0
        movieTimeLabel.lineBreakMode = .byWordWrapping
        
        ticketCountLabel.text = ""
        ticketCountLabel.font = .boldSystemFont(ofSize: 16)
        ticketCountLabel.textColor = .black
        
        
        // Footer
        oscarsLabel.text = "OSCARS"
        oscarsLabel.font = .boldSystemFont(ofSize: 45)
        oscarsLabel.textColor = .systemYellow
        
//        footerTextStackView.axis = .vertical
//        footerTextStackView.spacing = 5
//        footerTextStackView.alignment = .leading
//        ["레포 주소 레포 주소 레포 주소",
//         "레포 주소 레포 주소 레포 주소",
//         "레포 주소 레포 주소 레포 주소"].forEach {
//            let label = UILabel()
//            label.text = $0
//            label.textColor = .white
//            label.font = .systemFont(ofSize: 18)
//            footerTextStackView.addArrangedSubview(label)
//        }
        
        
        addSubview(headerView)
        headerView.addSubview(myPageLabel)
        headerView.addSubview(userNameLabel)
        headerView.addSubview(userIdLabel)
        headerView.addSubview(userEmailLabel)
        headerView.addSubview(logoutButton)
        headerView.addSubview(menuButton)
        headerView.addSubview(homeButton)
        
        addSubview(bookingHistoryTitleLabel)
        addSubview(bookingContainerView)
        bookingContainerView.addSubview(bookingStackView)
        bookingContainerView.addSubview(movieTitleLabel)
        bookingStackView.addArrangedSubview(posterImageView)
        bookingStackView.addArrangedSubview(movieInfoStackView)
        movieInfoStackView.addArrangedSubview(theaterNameLabel)
        movieInfoStackView.addArrangedSubview(movieDateLabel)
        movieInfoStackView.addArrangedSubview(movieTimeLabel)
        movieInfoStackView.addArrangedSubview(ticketCountLabel)
        
        addSubview(oscarsLabel)
//        addSubview(footerTextStackView)
    }
    
    
    private func setupLayout() {
        let padding: CGFloat = 40
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        homeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        myPageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeButton)
        }
        
        menuButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(homeButton)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        userIdLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-35)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        logoutButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(userNameLabel)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        bookingHistoryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        bookingContainerView.snp.makeConstraints {
            $0.top.equalTo(bookingHistoryTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(340)
        }
        
        bookingStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(250)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        movieInfoStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.lessThanOrEqualTo(posterImageView.snp.bottom)
        }
        
        oscarsLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-100)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
//        footerTextStackView.snp.makeConstraints {
//            $0.bottom.equalToSuperview().offset(-80)
//            $0.leading.equalToSuperview().offset(padding)
//        }
    }
}
