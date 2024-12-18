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
    
    @objc private func showDatePicker() { // 날짜 데이터
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
        
        // AutoLayout 설정
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: datePickerVC.view.topAnchor, constant: 10),
            confirmButton.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            confirmButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 모달을 맨 아래에 위치시키기
        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 250 }] // 높이를 250pt로 고정
            sheet.prefersGrabberVisible = true // 상단 핸들 표시
            sheet.preferredCornerRadius = 20   // 모달 상단의 라운드 처리
        }
        
        // 화이트 배경 적용
        presentWithWhiteBackground(datePickerVC, animated: true)
    }
    
    @objc private func showTimePicker() { //시간 데이터
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
        
        // AutoLayout 설정
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: timePickerVC.view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: timePickerVC.view.topAnchor, constant: 10),
            confirmButton.centerXAnchor.constraint(equalTo: timePickerVC.view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 10),
            confirmButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 모달을 맨 아래에 위치시키기
        if let sheet = timePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 250 }] // 높이를 250pt로 고정
            sheet.prefersGrabberVisible = true // 상단 핸들 표시
            sheet.preferredCornerRadius = 20   // 모달 상단의 라운드 처리
        }
        
        // 화이트 배경 적용
        presentWithWhiteBackground(timePickerVC, animated: true)
    }
    
    // MARK: - Update Total Price
    private func updateTotalPrice() {
        let totalPrice = peopleCount * 5000
        
        // NumberFormatter를 사용해 쉼표 추가
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 숫자 스타일을 소수점 형식으로 설정
        
        if let formattedPrice = formatter.string(from: NSNumber(value: totalPrice)) {
            bookingView.priceValueLabel.text = "\(formattedPrice)원"
        }
    }
}

// MARK: - UIViewController Extension for White Background
extension UIViewController {
    func presentWithWhiteBackground(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        // 모달 창에 화이트 배경 뷰 추가
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.frame = self.view.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 뷰 컨트롤러의 뷰에 배경 추가
        viewControllerToPresent.view.insertSubview(backgroundView, at: 0)
        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        
        // 모달 표시
        self.present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
