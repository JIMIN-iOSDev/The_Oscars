//
//  MovieListViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation
import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    // 컬렉션 뷰 생성
    
    
    // Upcoming Collection View
    private lazy var upcomingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = . white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Now Playing Collection View
    private lazy var nowPlayingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    // Popular Collection View
    private lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    // 더미 데이터
    private let upcomingMovies = ["영화1", "영화2", "영화3", "영화4", "영화5"]
    private let nowPlayingMovies = ["상영1", "상영2", "상영3", "상영4", "상영5"]
    private let popularMovies = ["인기1", "인기2", "인기3", "인기4", "인기5"]
    
    // 스택뷰 생성
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // 스택뷰 안에 컬렉션 뷰 추가
        stackView.addArrangedSubview(upcomingCollectionView)
        stackView.addArrangedSubview(nowPlayingCollectionView)
        stackView.addArrangedSubview(popularCollectionView)
        
        // 스택뷰를 뷰에 추가
        view.addSubview(stackView)
        
        // 스택뷰 설정 값
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰 계층 구조에 추가
        view.addSubview(stackView)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            
            // 스택뷰 위치 및 크기 설정 (화면 전체에 맞춤)
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
}

// MARK: - UIColletionViewDelegate, UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection numberOfItemsInssectionsection: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingMovies.count
        case nowPlayingCollectionView:
            return nowPlayingMovies.count
        case popularCollectionView:
            return popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
            
        }
        
        let title: String
        switch collectionView {
        case upcomingCollectionView:
            title = upcomingMovies[indexPath.item]
        case nowPlayingCollectionView:
            title = nowPlayingMovies[indexPath.item]
        case popularCollectionView:
            title = popularMovies[indexPath.item]
        default:
            title = ""
        }
        
        cell.configure(with: title)
        return cell
    }
}
