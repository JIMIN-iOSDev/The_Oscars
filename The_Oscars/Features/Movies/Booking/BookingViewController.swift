//
//  BookingViewController.swift
//  The_Oscars
//
//  Created by sol on 12/16/24.
//

import UIKit

class MovieBookingViewController: UIViewController {
    
    // MARK: - UI Components
    let bookingView = MovieBookingView() // 커스텀 뷰 추가
    
    // MARK: - Variables
    var peopleCount: Int = 0 {
        didSet {
            bookingView.countLabel.text = "\(peopleCount)"
            updateTotalPrice()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = bookingView
        setupActions()
    }
    
    // MARK: - Actions
    private func setupActions() {
        bookingView.plusButton.addTarget(self, action: #selector(increasePeopleCount), for: .touchUpInside)
        bookingView.minusButton.addTarget(self, action: #selector(decreasePeopleCount), for: .touchUpInside)
    }
    
    @objc private func increasePeopleCount() {
        if peopleCount < 10 {
            peopleCount += 1
        }
    }
    
    @objc private func decreasePeopleCount() {
        if peopleCount > 0 {
            peopleCount -= 1
        }
    }
    
    // MARK: - Update Total Price
    private func updateTotalPrice() {
        let totalPrice = peopleCount * 5000
        bookingView.priceValueLabel.text = "\(totalPrice)원"
    }
}
