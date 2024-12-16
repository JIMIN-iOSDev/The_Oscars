//
//  SearchViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 검색창
    private let searchTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .lightGray
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.attributedPlaceholder = NSAttributedString(string: "영화 제목을 검색하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textfield
    }()
    
    // 추천 글씨
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 영화"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private var recommendedMovies: [(imageURL: String, title: String)] = [
            ("https://image.tmdb.org/t/p/w500/movie1.jpg", "영화1"),
            ("https://image.tmdb.org/t/p/w500/movie2.jpg", "영화2"),
            ("https://image.tmdb.org/t/p/w500/movie3.jpg", "영화3"),
            ("https://image.tmdb.org/t/p/w500/movie4.jpg", "영화4"),
            ("https://image.tmdb.org/t/p/w500/movie5.jpg", "영화5"),
            ("https://image.tmdb.org/t/p/w500/movie6.jpg", "영화6")
        ]
        
        // CollectionView
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40) / 3, height: (UIScreen.main.bounds.width - 40) / 3 + 40) // 3개의 이미지
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        searchTextfield.delegate = self
        searchTextfield.becomeFirstResponder()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register custom cell for the collection view
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
        
        configureUI()
    }
    
    private func configureUI() {

        [searchTextfield, recommendLabel, collectionView]
            .forEach { view.addSubview($0) }
        
        searchTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(50)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextfield.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints {
                $0.top.equalTo(recommendLabel.snp.bottom).offset(20)
                $0.left.right.bottom.equalToSuperview().offset(0)
            }
    }
    
    // 엔터 키 누르면 키보드 사라지고 검색이 가능
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchQuery = textField.text, !searchQuery.isEmpty {
            print("검색할 영화: \(searchQuery)")
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return recommendedMovies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
            
            // Set image and title for each cell
            let movie = recommendedMovies[indexPath.item]
            cell.configure(imageURL: movie.imageURL, title: movie.title)
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (UIScreen.main.bounds.width - 40) / 3 // 3 items per row
            return CGSize(width: width, height: width + 40) // Set height based on image width
        }
    }

    // MARK: - Custom UICollectionViewCell

    class MovieCell: UICollectionViewCell {
        
        private let movieImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(movieImageView)
            contentView.addSubview(titleLabel)
            
            movieImageView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(movieImageView.snp.width) // Make it square
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(movieImageView.snp.bottom).offset(5)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(imageURL: String, title: String) {
            // Set the title
            titleLabel.text = title
            
            // Load the image (You can use libraries like SDWebImage or Kingfisher to load images from URL)
            if let url = URL(string: imageURL) {
                // Here we'll use a simple way to load the image, but you can use a library like SDWebImage for caching.
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    movieImageView.image = UIImage(data: imageData)
                }
            }
        }
}

