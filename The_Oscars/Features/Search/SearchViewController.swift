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
        
        // 셀 등록
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 셀 크기, 간격
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
        filteredMovies = movies  // 처음에는 전체 영화목록
        collectionView.reloadData()
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
        filterItems(with: "")
    }
    
    private func filterItems(with searchText: String) {
            if searchText.isEmpty {
                filteredMovies = movies
            } else {
                filteredMovies = movies.filter { $0.title.range(of: searchText, options: .caseInsensitive) != nil }
            }
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
        return cell
    }
    
    // 셀이 선택되었을 때 실행될 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 상세 페이지 넘어가기
        let detailVC = MovieDetailController()
        navigationController?.pushViewController(detailVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        searchBar.resignFirstResponder()
    }
}

