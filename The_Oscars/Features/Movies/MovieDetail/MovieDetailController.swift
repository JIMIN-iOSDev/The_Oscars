//
//  MovieDetailController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class MovieDetailController: UIViewController {
    var movie: Movie?
    
    //MARK: - UI Components
    // 포스터
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        return image
    }()
    
    // 영화 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // 개봉일
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // 평점
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    // 세부설명
    private let explanationScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // 예매 버튼
    private lazy var bookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매하기", for: .normal)
        button.setTitleColor(UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0), for: .normal)
        button.layer.borderColor = UIColor(red: 237/255, green: 206/255, blue: 85/255, alpha: 1.0).cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureUI()
        loadMovieDetails()
    }
    
    // MARK: - 예매 버튼 액션
    @objc private func bookingButtonTapped() {
        let bookingVC = MovieBookingViewController() // 예매 페이지 인스턴스 생성
        bookingVC.modalPresentationStyle = .pageSheet // 모달 스타일 설정
        bookingVC.movie = movie // 예매 페이지에 영화 정보 전달
        present(bookingVC, animated: true, completion: nil) // 모달 띄우기
    }
    
    private func loadMovieDetails() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        dateLabel.text = "개봉일 \(movie.releaseDate ?? "미정")"
        
        if let voteAverage = movie.voteAverage {
            gradeLabel.text = "❤️\(String(format: "%.1f", voteAverage))"
        } else {
            gradeLabel.text = "❤️0.0"
        }
        explanationLabel.text = movie.overview
        
        // 포스터 이미지 로드
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadImage(from: urlString)
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: data)
            }
        }.resume()
    }
    
    //MARK: - configureUI()
    private func configureUI() {
        
        [movieImage, titleLabel, dateLabel, gradeLabel, explanationScrollView, bookingButton]
            .forEach { view.addSubview($0) }
        
        explanationScrollView.addSubview(explanationLabel)
        
        movieImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
            $0.width.equalTo(view.bounds.width - 140)
            $0.height.equalTo(view.bounds.height / 2)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.bottom).offset(15)
            $0.leading.equalTo(movieImage.snp.leading)
            $0.height.equalTo(25)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(movieImage.snp.leading)
            $0.height.equalTo(20)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(movieImage.snp.trailing)
        }
        
        explanationScrollView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.leading.equalTo(movieImage.snp.leading)
            $0.trailing.equalTo(movieImage.snp.trailing)
            $0.bottom.equalTo(bookingButton.snp.top).offset(-15)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(explanationScrollView.snp.top).offset(10)
            $0.leading.equalTo(explanationScrollView.snp.leading).offset(10)
            $0.trailing.equalTo(explanationScrollView.snp.trailing).offset(-10)
            $0.bottom.equalTo(explanationScrollView.snp.bottom).offset(-10)
            
            $0.width.equalTo(view.bounds.width - 160)
            $0.height.greaterThanOrEqualTo(explanationScrollView.snp.height)
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

//MARK: - extension
// 뒤로가기 제스쳐 extension
extension MovieDetailController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

