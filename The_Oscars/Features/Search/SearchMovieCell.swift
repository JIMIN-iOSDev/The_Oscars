//
//  MovieCell.swift
//  The_Oscars
//
//  Created by Jimin on 12/17/24.
//

import UIKit

class SearchMovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SearchMovieCell"
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [posterImageView, titleLabel]
            .forEach { contentView.addSubview($0) }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(contentView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(5)
            $0.centerX.equalTo(contentView)
            $0.leading.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView).offset(-5)
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title ?? "No Title"
        
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
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
