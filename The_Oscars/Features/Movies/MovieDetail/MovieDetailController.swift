//
//  MovieDetailController.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit
import SnapKit

class MovieDetailController: UIViewController {
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .cyan
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
        configureUI()
        
    }
    
    private func configureUI() {
        
        view.addSubview(movieImage)
        
        movieImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(view.bounds.width / 2)
            $0.height.equalTo(view.bounds.height / 3)
        }
    }
}

#Preview {
    MovieDetailController()
}
