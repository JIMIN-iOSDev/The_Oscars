//
//  MovieBookingView.swift
//  The_Oscars
//
//  Created by t2023-m105 on 12/18/24.
//

import UIKit
import SnapKit

class MovieBookingView: UIView {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "예매하기"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .systemYellow
        return label
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "영화명"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
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
        button.setTitleColor(.systemYellow, for: .normal)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.systemYellow, for: .normal)
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
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
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
        [titleLabel, movieNameLabel, dateLabel, peopleLabel, countLabel, minusButton, plusButton, priceLabel, priceValueLabel, bookButton].forEach {
            addSubview($0)
        }
        
        // Layout
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(20)
        }
        
        peopleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(130)
            make.leading.equalToSuperview().offset(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.trailing.equalTo(countLabel.snp.leading).offset(-20)
            make.width.height.equalTo(40)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(peopleLabel)
            make.leading.equalTo(countLabel.snp.trailing).offset(20)
            make.width.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(peopleLabel.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(20)
        }
        
        priceValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        bookButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(130)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
