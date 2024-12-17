//
//  MovieDetailController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class MovieDetailController: UIViewController {
    //MARK: - UI Components
    // 포스터
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .cyan
        return image
    }()
    
    // 영화 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제예정"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // 개봉일
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제예정2"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // 누적 관객 수
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제예정3"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // 평점
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제예정4"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    // 세부설명
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.text = "삭제예정5"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // 예매 버튼
    private let bookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매하기", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)

        // 버튼 없이 제스쳐로 뒤로 가기 - 네비게이션 테스트 버튼 연결해도 해결안됨
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        configureUI()
        
    }
    
    //MARK: - configureUI()
    private func configureUI() {
        
        [movieImage, titleLabel, dateLabel, audienceLabel, gradeLabel, explanationLabel, bookingButton]
            .forEach { view.addSubview($0) }
        
        movieImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(view.bounds.width - 140)
            $0.height.equalTo(view.bounds.height / 2)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.bottom).offset(25)
            $0.leading.equalTo(movieImage.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(movieImage.snp.leading)
        }
        
        audienceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(movieImage.snp.leading)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top).offset(7.5)
            $0.trailing.equalTo(movieImage.snp.trailing)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(audienceLabel.snp.bottom).offset(30)
            $0.leading.equalTo(movieImage.snp.leading)
        }
        
        bookingButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(movieImage.snp.leading)
            $0.trailing.equalTo(movieImage.snp.trailing)
            $0.height.equalTo(40)
        }
    }
}

