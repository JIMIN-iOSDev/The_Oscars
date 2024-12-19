//
//  TabBarViewController.swift
//  The_Oscars
//
//  Created by YangJeongMu on 12/16/24.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        fetchMovies()
    }
    
    //TODO: -movie data fetch
    private func fetchMovies() {
//        NetworkManager.shared.fetchMovies(category: .popular, page: 1) { result in
//            switch result {
//            case .success(let movieResponse):
//                print("성공: \(movieResponse)")
//            case .failure(let error):
//                print("에러 발생: \(error.localizedDescription)")
//            }
//        }
    }
    
    private func setupTabBar() {
        
        let movieListVC = MovieListViewController()
        let searchVC = SearchViewController()
        let mypageVC = MyPageViewController()
        
        //탭바 아이템 설정
        movieListVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "sparkle.magnifyingglass"), tag: 1)
        mypageVC.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "rectangle.badge.person.crop"), tag: 2)
        
        self.tabBar.tintColor = .black
        
        viewControllers = [movieListVC, searchVC, mypageVC]
    }
}
