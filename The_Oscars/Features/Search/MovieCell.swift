//
//  MovieCell.swift
//  The_Oscars
//
//  Created by Jimin on 12/17/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [titleLabel, posterImageView]
            .forEach { contentView.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }

        posterImageView.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.trailing.equalTo(contentView)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-10)
        }
    }
}
