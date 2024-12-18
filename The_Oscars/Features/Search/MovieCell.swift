//
//  MovieCell.swift
//  The_Oscars
//
//  Created by Jimin on 12/17/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    

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
            $0.top.equalTo(posterImageView.snp.bottom).offset(10)
            $0.centerX.equalTo(contentView)
            $0.bottom.equalTo(contentView).offset(-10)
        }
    }
}
