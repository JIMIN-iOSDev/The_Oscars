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
    let movieTimeTextLabel = UILabel()
    let movieTimeLabel = UILabel()
    let ticketCountLabel = UILabel()
    
    // Footer
    let oscarsLabel = UILabel()
    let footerTextStackView = UIStackView()
    
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
        backgroundColor = .darkGray
        
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
        
        userNameLabel.text = "김민지님"
        userNameLabel.font = .boldSystemFont(ofSize: 26)
        userNameLabel.textColor = .black
        
        userIdLabel.text = "아이디"
        userIdLabel.font = .systemFont(ofSize: 18)
        userIdLabel.textColor = .black
        
        userEmailLabel.text = "이메일주소"
        userEmailLabel.font = .systemFont(ofSize: 18)
        userEmailLabel.textColor = .black
        
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 5
        
        menuButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        
        
        // 예매 내역 타이틀
        bookingHistoryTitleLabel.text = "예매 내역"
        bookingHistoryTitleLabel.font = .boldSystemFont(ofSize: 30)
        bookingHistoryTitleLabel.textColor = .white
        
        // 예매 내역 컨테이너 뷰
        bookingContainerView.backgroundColor = .gray
        bookingContainerView.layer.cornerRadius = 10
        
        // 예매 내역 스택뷰
        bookingStackView.axis = .horizontal
        bookingStackView.spacing = 20
        bookingStackView.alignment = .top
        bookingStackView.distribution = .fill
        
        posterImageView.backgroundColor = .lightGray
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
        
        movieTitleLabel.text = "영화 제목"
        movieTitleLabel.font = .boldSystemFont(ofSize: 30)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .white
        
        movieInfoStackView.axis = .vertical
        movieInfoStackView.spacing = 40
        movieInfoStackView.alignment = .leading
        movieInfoStackView.distribution = .fill
        
        theaterNameLabel.text = "스파르타 상영관"
        theaterNameLabel.font = .boldSystemFont(ofSize: 20)
        theaterNameLabel.textColor = .white
        
        movieTimeTextLabel.text = "상영 시간"
        movieTimeTextLabel.font = .boldSystemFont(ofSize: 20)
        movieTimeTextLabel.textColor = .white
        
        movieTimeLabel.text = "00시 00분"
        movieTimeLabel.font = .systemFont(ofSize: 16)
        movieTimeLabel.textColor = .white
        
        ticketCountLabel.text = "매표 개수"
        ticketCountLabel.font = .boldSystemFont(ofSize: 20)
        ticketCountLabel.textColor = .white
        
        
        // Footer
        oscarsLabel.text = "OSCARS"
        oscarsLabel.font = .boldSystemFont(ofSize: 30)
        oscarsLabel.textColor = .systemYellow
        
        footerTextStackView.axis = .vertical
        footerTextStackView.spacing = 5
        footerTextStackView.alignment = .leading
        ["레포 주소 레포 주소 레포 주소",
         "레포 주소 레포 주소 레포 주소",
         "레포 주소 레포 주소 레포 주소"].forEach {
            let label = UILabel()
            label.text = $0
            label.textColor = .white
            label.font = .systemFont(ofSize: 18)
            footerTextStackView.addArrangedSubview(label)
        }
        
        
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
        movieInfoStackView.addArrangedSubview(movieTimeTextLabel)
        movieInfoStackView.addArrangedSubview(movieTimeLabel)
        movieInfoStackView.addArrangedSubview(ticketCountLabel)
        
        addSubview(oscarsLabel)
        addSubview(footerTextStackView)
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
            $0.leading.equalTo(bookingContainerView).offset(60)
        }
        
        movieInfoStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.lessThanOrEqualTo(posterImageView.snp.bottom)
        }
        
        oscarsLabel.snp.makeConstraints {
            $0.bottom.equalTo(footerTextStackView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset(padding)
        }
        
        footerTextStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-80)
            $0.leading.equalToSuperview().offset(padding)
        }
    }
}
