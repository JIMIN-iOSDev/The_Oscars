//
//  BookingViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
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
        label.textAlignment = .left // 좌측 정렬
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup Views
    private func setupView() {
        view.backgroundColor = .white
        
        // Add Subviews
        [titleLabel, movieNameLabel, dateLabel, peopleLabel, priceLabel, bookButton].forEach {
            view.addSubview($0)
        }
        
        // Layout with SnapKit
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        peopleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(peopleLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        bookButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
