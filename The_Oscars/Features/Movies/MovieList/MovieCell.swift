//
//  MovieListCollectionViewCell.swift
//  The_Oscars
//
//  Created by YangJeongMu on 12/18/24.
//
import UIKit
import SnapKit

// MARK: - MovieCellDelegate
protocol MovieCellDelegate: AnyObject {
    func didTapMoviePoster(_ cell: MovieCell)
    func didTapBookingButton(_ cell: MovieCell)
}

// MARK: - MovieCell
class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var delegate: MovieCellDelegate?
    
    // MARK: - UI Components
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let bookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("바로예매", for: .normal)
        // 텍스트 색상을 흰색으로 설정
        button.setTitleColor(.white, for: .normal)
        // 배경색을 골드 컬러로 설정
        button.backgroundColor = UIColor(red: 0.929, green: 0.808, blue: 0.333, alpha: 1)
        // 테두리 설정
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.929, green: 0.808, blue: 0.333, alpha: 1).cgColor
        // 폰트 설정 (Inter-Bold 폰트가 없을 경우를 대비해 systemFont도 설정)
        if let customFont = UIFont(name: "Inter-Bold", size: 11) {
            button.titleLabel?.font = customFont
        } else {
            button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        }
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    private let viewerCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .white
        
        [posterImageView, bookingButton, titleLabel, infoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [viewerCountLabel, heartButton, ratingLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookingButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(posterTapped))
        posterImageView.addGestureRecognizer(tapGesture)
        
        bookingButton.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func posterTapped() {
        delegate?.didTapMoviePoster(self)
    }
    
    @objc private func bookingButtonTapped() {
        delegate?.didTapBookingButton(self)
    }
    
    // MARK: - Configuration
    func configure(with movie: Movie, image: UIImage? = nil) {
        titleLabel.text = movie.title
        
        if let image = image {
            posterImageView.image = image
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }
        
        if let voteAverage = movie.voteAverage {
            ratingLabel.text = String(format: "평점 %.1f", voteAverage)
        }
        
        if let voteCount = movie.voteCount {
            viewerCountLabel.text = "평가수 \(voteCount)"
        }
        
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadImage(from: urlString)
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
        viewerCountLabel.text = nil
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
