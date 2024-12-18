//
//  SearchViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    //MARK: - UI Components
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var currentPage: Int = 1
    private var isLoading = false
    
    // searchBar
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.searchBarStyle = .default
        search.showsCancelButton = true
        search.searchTextField.backgroundColor = .lightGray
        search.searchTextField.borderStyle = .roundedRect
        search.searchTextField.autocapitalizationType = .none
        return search
    }()
    
    // collectionView
    struct CVCell {
        static let spacingWidth: CGFloat = 1
        static let cellColumns: CGFloat = 3
        private init() {}
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        // cell 등록
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // cell 크기, 간격
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth + 30)
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth
        
        return collectionView
    }()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        fetchMovies()
    }
    
    //MARK: - configureUI()
    private func configureUI() {
        [searchBar, collectionView]
            .forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchMovies() {
        guard !isLoading else { return } // 이미 로딩 중이면 추가 요청하지 않도록 처리
        isLoading = true
        
        NetworkManager.shared.fetchMovies(category: .popular, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movieResponse):
                // 페이지가 더 있으면 페이지 증가
                self.currentPage += 1
                
                // 기존 데이터에 새로운 데이터를 추가
                self.movies.append(contentsOf: movieResponse.results)
                self.filteredMovies = self.movies // 필터된 영화 목록을 갱신
                
                DispatchQueue.main.async {
                    print("Fetched movies: \(self.movies.count)")
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
            
            self.isLoading = false
        }
    }
}

//MARK: - extension
// searchBar extension
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
        filteredMovies = movies
        collectionView.reloadData()
    }
    
    private func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter {
                return ($0.title ?? "").range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        print("Filtered Movies Count: \(filteredMovies.count)")
        collectionView.reloadData()
    }
}

// CollectionView extension
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    // 셀에 담을 데이터 표시
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 재사용 가능한 셀을 꺼내서 사용하는 메서드
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    // 셀이 선택되었을 때 실행될 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        // 상세 페이지 넘어가기
        let detailVC = MovieDetailController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        searchBar.resignFirstResponder()
    }
    
    // 컬렉션 뷰의 마지막 셀에 도달했을 때 추가 데이터 불러오기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentHeight = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        let frameHeight = scrollView.frame.size.height
        
        if contentOffsetY + frameHeight >= contentHeight - 200 {
            fetchMovies()
        }
    }
}

