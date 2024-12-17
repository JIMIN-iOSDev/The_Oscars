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
    private let upcomingCollectionView = UICollectionView(
        frame: .zero,
        
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let nowPlayingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let popularCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    // 스택뷰 생성
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 스택뷰 안에 컬렉션 뷰 추가
        stackView.addArrangedSubview(upcomingCollectionView)
        stackView.addArrangedSubview(nowPlayingCollectionView)
        stackView.addArrangedSubview(popularCollectionView)
        
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
