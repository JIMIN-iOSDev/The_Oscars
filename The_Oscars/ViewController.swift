//
//  ViewController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(navigateToSearchScreen), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    @objc func navigateToSearchScreen() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
