//
//  MovieListCollectionViewCell.swift
//  The_Oscars
//
//  Created by YangJeongMu on 12/18/24.
//


// 바로 예매페이지 누르면 예매 페이지 누르기
// 영화 세부 페이지면 상세페이지 넘어가기
// 영화 포스트 누르면 세부 페이지 넘어가기

import UIKit

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
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
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
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    private let viewerCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
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
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4),
            
            bookingButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            bookingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookingButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: bookingButton.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
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
