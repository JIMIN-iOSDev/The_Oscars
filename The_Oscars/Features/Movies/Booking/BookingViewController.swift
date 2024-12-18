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
        bookingView.dateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        bookingView.timeButton.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
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
    
    @objc private func showDatePicker() {
        let datePickerVC = UIViewController()
        datePickerVC.modalPresentationStyle = .pageSheet
        datePickerVC.preferredContentSize = CGSize(width: view.frame.width, height: 250)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        datePickerVC.view.addSubview(datePicker)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 50)
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            self.bookingView.dateButton.setTitle(formatter.string(from: datePicker.date), for: .normal)
            datePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        datePickerVC.view.addSubview(confirmButton)

        present(datePickerVC, animated: true)
    }
    
    @objc private func showTimePicker() {
        let timePickerVC = UIViewController()
        timePickerVC.modalPresentationStyle = .pageSheet
        timePickerVC.preferredContentSize = CGSize(width: view.frame.width, height: 250)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        timePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        timePickerVC.view.addSubview(timePicker)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 50)
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            self.bookingView.timeButton.setTitle(formatter.string(from: timePicker.date), for: .normal)
            timePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        timePickerVC.view.addSubview(confirmButton)

        present(timePickerVC, animated: true)
    }
    
    // MARK: - Update Total Price
    private func updateTotalPrice() {
        let totalPrice = peopleCount * 5000
        bookingView.priceValueLabel.text = "\(totalPrice)원"
    }
}
