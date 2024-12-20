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
    }
    
    private func setupTabBar() {
        let movieListVC = MovieListViewController()
        let movieListNavVC = UINavigationController(rootViewController: movieListVC)
        let searchVC = SearchViewController()
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        let mypageVC = MyPageViewController()
        let mypageNavVC = UINavigationController(rootViewController: mypageVC)
        
        //탭바 아이템 설정
        movieListVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "sparkle.magnifyingglass"), tag: 1)
        mypageVC.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "rectangle.badge.person.crop"), tag: 2)
        
        self.tabBar.tintColor = .black
        
        viewControllers = [movieListNavVC, searchNavVC, mypageNavVC]
    }
}
