//
//  MovieListViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    // 네트워크
    private let networkManager = NetworkManager.shared
    private var upcomingMovies: [Movie] = [] // 개봉 예정 영화를 담을 배열
    private var nowPlayingMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    
    
    // Upcoming Collection View
    private lazy var upcomingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 280)
        layout.minimumLineSpacing = 16
        
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
    
    // 스택뷰 생성
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadMovieData()
        setupUI()
    }
    
    // 로딩 데이터
    private func loadMovieData() {
        loadUpcomingMovies()
        loadNowPlayingMovies()
        loadPopularMovies()
    }
    
    private func loadUpcomingMovies() {
        networkManager.fetchMovies(category: .upcoming) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let response):
                self?.upcomingMovies = response.results
                DispatchQueue.main.async {
                    self?.upcomingCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error loading upcoming movies: \(error)")
            }
        }
    }
    
    private func loadNowPlayingMovies() {
        networkManager.fetchMovies(category: .nowPlaying) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let response):
                self?.nowPlayingMovies = response.results
                DispatchQueue.main.async {
                    self?.nowPlayingCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error loading now playing movies: \(error)")
            }
        }
    }
    
    private func loadPopularMovies() {
        networkManager.fetchMovies(category: .popular) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let response):
                self?.popularMovies = response.results
                DispatchQueue.main.async {
                    self?.popularCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error loading popular movies: \(error)")
            }
        }
    }
    
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // 스택뷰 설정 값
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰 계층 구조에 추가
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(700)
        }
        
    }
}

// MARK: - UIColletionViewDelegate, UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        
        let movie: Movie
        switch collectionView {
        case upcomingCollectionView:
            movie = upcomingMovies[indexPath.item]
        case nowPlayingCollectionView:
            movie = nowPlayingMovies[indexPath.item]
        case popularCollectionView:
            movie = popularMovies[indexPath.item]
        default:
            return UICollectionViewCell()
        }
        
        
        cell.configure(with: movie)
        
        return cell
    }
    
    
    // MARK: - Collection View Setup
    private func setupCollectionView() {
        // 각 섹션의 헤더 레이블 생성
        let upcomingHeaderView = createHeaderView(title: "Upcoming Movies")
        let nowPlayingHeaderView = createHeaderView(title: "Now Playing")
        let popularHeaderView = createHeaderView(title: "Popular Movies")
        
        // 스택뷰에 헤더와 컬렉션뷰 추가
        let upcomingStack = createSectionStack(headerView: upcomingHeaderView, collectionView: upcomingCollectionView)
        let nowPlayingStack = createSectionStack(headerView: nowPlayingHeaderView, collectionView: nowPlayingCollectionView)
        let popularStack = createSectionStack(headerView: popularHeaderView, collectionView: popularCollectionView)
        
        stackView.addArrangedSubview(upcomingStack)
        stackView.addArrangedSubview(nowPlayingStack)
        //         stackView.addArrangedSubview(popularStack)
    }
    
    private func createHeaderView(title: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return headerView
    }
    
    private func createSectionStack(headerView: UIView, collectionView: UICollectionView) -> UIStackView {
        let sectionStack = UIStackView(arrangedSubviews: [headerView, collectionView])
        sectionStack.axis = .vertical
        sectionStack.spacing = 8
        return sectionStack
    }
}

extension MovieListViewController: MovieCellDelegate {
    func didTapMoviePoster(_ cell: MovieCell) {
        if let indexPath = upcomingCollectionView.indexPath(for: cell) {
            let movie = upcomingMovies[indexPath.item]
            presentMovieDetail(for: movie)
        } else if let indexPath = nowPlayingCollectionView.indexPath(for: cell) {
            let movie = nowPlayingMovies[indexPath.item]
            presentMovieDetail(for: movie)
        } else if let indexPath = popularCollectionView.indexPath(for: cell) {
            let movie = popularMovies[indexPath.item]
            presentMovieDetail(for: movie)
        }
    }
    func didTapBookingButton(_ cell: MovieCell) {
        // 예매 페이지로 이동하는 로직 구현
        // 현재는 임시로 알림만 표시
        let alert = UIAlertController(title: "예매하기",
                                      message: "예매 페이지로 이동합니다.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func presentMovieDetail(for movie: Movie) {
        // 상세 페이지로 이동하는 로직
        // MovieDetailViewController 구현 후 연결 필요
        let alert = UIAlertController(title: movie.title,
                                      message: movie.overview,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}




// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 300)
    }
}
