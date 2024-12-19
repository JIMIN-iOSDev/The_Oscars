//
//  MovieBookingView.swift
//  The_Oscars
//
//  Created by sol on 12/18/24.
//

import UIKit
import SnapKit

class MovieBookingView: UIView {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "예매하기"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0)
        return label
    }()
    
    let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white // 로딩 시 기본 배경색
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "영화명"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let peopleLabel: UILabel = {
        let label = UILabel()
        label.text = "인원"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0), for: .normal)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0), for: .normal)
        return button
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "총 가격"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let priceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    let bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("결제하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("날짜 선택", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 8
        return button
    }()
    
    let timeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시간 선택", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupView() {
        backgroundColor = .white
        
        // Add Subviews
        [titleLabel, moviePosterImageView, movieNameLabel, dateLabel, peopleLabel, countLabel, minusButton, plusButton, priceLabel, priceValueLabel, bookButton, dateButton, timeButton].forEach {
            addSubview($0)
        }
        
        // Layout
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(350) // 포스터 크기 고정
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview() // 가로 중앙 정렬
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        peopleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.trailing.equalToSuperview().offset(-60) // 부모 뷰의 오른쪽 끝에서 60pt 안쪽
            make.width.equalTo(50)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.trailing.equalTo(countLabel.snp.leading).offset(-10) // 숫자 라벨 왼쪽
            make.width.height.equalTo(40)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.leading.equalTo(countLabel.snp.trailing).offset(10) // 숫자 라벨 오른쪽
            make.width.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(peopleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        priceValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        bookButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        dateButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel) // 날짜 라벨의 세로 중앙 정렬
            make.trailing.equalToSuperview().offset(-140) // 부모 뷰의 오른쪽에서 140pt 안쪽
            make.width.equalTo(120) // 버튼 너비
            make.height.equalTo(40) // 버튼 높이
        }
        
        timeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel) // 날짜 라벨의 세로 중앙 정렬
            make.leading.equalTo(dateButton.snp.trailing).offset(10) // 날짜 선택 버튼 오른쪽에 배치
            make.trailing.lessThanOrEqualToSuperview().offset(-20) // 부모 뷰의 오른쪽 끝에서 20pt 안쪽
            make.width.equalTo(120) // 버튼 너비
            make.height.equalTo(40) // 버튼 높이
        }
    }
}
