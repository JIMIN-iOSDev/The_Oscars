//
//  UIView+AddSubviews.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
