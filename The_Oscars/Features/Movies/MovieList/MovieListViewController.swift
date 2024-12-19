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
    
    // 상단 로고
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OSCARS"
        label.textColor = UIColor(red: 0.929, green: 0.808, blue: 0.333, alpha: 1)
        label.font = .systemFont(ofSize: 36, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        
        // 타이틀 레이블 추가
        view.addSubview(titleLabel)
        
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
        
        // 타이틀 레이블 제약조건
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
            make.width.equalTo(159)
            make.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(1050)
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
        stackView.addArrangedSubview(popularStack)
    }
    
    private func createHeaderView(title: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        // SnapKit을 사용한 제약조건 설정
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
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
    // 예매 페이지로 이동하는 로직 구현
    func didTapBookingButton(_ cell: MovieCell) {
        var selectedMovie: Movie?

        if let indexPath = upcomingCollectionView.indexPath(for: cell) {
            selectedMovie = upcomingMovies[indexPath.item]
        } else if let indexPath = nowPlayingCollectionView.indexPath(for: cell) {
            selectedMovie = nowPlayingMovies[indexPath.item]
        } else if let indexPath = popularCollectionView.indexPath(for: cell) {
            selectedMovie = popularMovies[indexPath.item]
        }
        
        if let movie = selectedMovie {
            let bookingVC = MovieBookingViewController()
            bookingVC.hidesBottomBarWhenPushed = true
            bookingVC.movie = movie
            bookingVC.modalPresentationStyle = .pageSheet // 모달 형식 설정
            present(bookingVC, animated: true, completion: nil) // 모달로 띄움
        }
    }
    
    private func presentMovieDetail(for movie: Movie) {
        print(2222)
        // 상세 페이지로 이동하는 로
        let detailVC = MovieDetailController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 300)
    }
}
