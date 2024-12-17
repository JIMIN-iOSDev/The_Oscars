//
//  BookingViewController.swift
//  The_Oscars
//
//  Created by sol on 12/16/24.
//

import UIKit
import SnapKit

class MovieBookingViewController: UIViewController {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "예매하기"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .systemBlue
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
    
    let countLabel: UILabel = { // 인원 수 표시
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let minusButton: UIButton = { // 마이너스 버튼
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    let plusButton: UIButton = { // 플러스 버튼
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "총 가격"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("결제하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Variables
    var peopleCount: Int = 1 {
        didSet {
            countLabel.text = "\(peopleCount)"
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    // MARK: - Setup Views
    private func setupView() {
        view.backgroundColor = .white
        
        // Add Subviews
        [titleLabel, movieNameLabel, dateLabel, peopleLabel, countLabel, minusButton, plusButton, priceLabel, bookButton].forEach {
            view.addSubview($0)
        }
        
        // Layout
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.equalToSuperview().offset(20)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        peopleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 인원 수와 버튼
        countLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(peopleLabel) // 세로 정렬
            make.centerX.equalToSuperview()   // 화면 중앙에 배치
            make.width.equalTo(50)
        }

        minusButton.snp.remakeConstraints { make in
            make.centerY.equalTo(peopleLabel) // 세로 정렬
            make.trailing.equalTo(countLabel.snp.leading).offset(-20) // 숫자 왼쪽에 배치
            make.width.height.equalTo(40)
        }

        plusButton.snp.remakeConstraints { make in
            make.centerY.equalTo(peopleLabel) // 세로 정렬
            make.leading.equalTo(countLabel.snp.trailing).offset(20) // 숫자 오른쪽에 배치
            make.width.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(peopleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        bookButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    private func setupActions() {
        plusButton.addTarget(self, action: #selector(increasePeopleCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreasePeopleCount), for: .touchUpInside)
    }
    
    @objc private func increasePeopleCount() {
        if peopleCount < 10 { // 최대 인원 수 제한
            peopleCount += 1
        }
    }
    
    @objc private func decreasePeopleCount() {
        if peopleCount > 1 { // 최소 인원 수 제한
            peopleCount -= 1
        }
    }
}
