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
    var movie: Movie? // 전달받은 영화 정보
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
        loadMovieDetails() // 영화 정보 로드
    }
    
    // MARK: - Load Movie Details
    private func loadMovieDetails() {
        guard let movie = movie else { return }
        
        // 영화명 설정
        bookingView.movieNameLabel.text = movie.title
        
        // 포스터 이미지 로드
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadPosterImage(from: urlString)
        }
    }
    
    private func loadPosterImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.bookingView.moviePosterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        bookingView.plusButton.addTarget(self, action: #selector(increasePeopleCount), for: .touchUpInside)
        bookingView.minusButton.addTarget(self, action: #selector(decreasePeopleCount), for: .touchUpInside)
        bookingView.dateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        bookingView.timeButton.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        bookingView.bookButton.addTarget(self, action: #selector(bookMovie), for: .touchUpInside)
    }
    
    //MARK: - Actions
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
    
    @objc private func bookMovie() {
        guard let movieName = bookingView.movieNameLabel.text,
              let date = bookingView.dateButton.title(for: .normal), // 날짜 가져오기
              let time = bookingView.timeButton.title(for: .normal), // 시간 가져오기
              !date.isEmpty, !time.isEmpty else { // 날짜와 시간이 선택되었는지 확인
            showAlert(message: "날짜와 시간을 선택해주세요!")
            return
        }
        
        let totalPrice = peopleCount * 5000 // 총 가격 계산
        let booking = Booking(movieName: movieName, date: date, time: time, peopleCount: peopleCount, totalPrice: totalPrice) // Booking 객체 생성
        
        UserDefaultsManager.shared.saveBooking(booking) // UserDefaults에 저장
        print("예매 정보가 저장되었습니다: \(booking)")
        
        // 네비게이션 스택에서 MovieListViewController로 이동
        if let movieListVC = navigationController?.viewControllers.first(where: { $0 is MovieListViewController }) {
            navigationController?.popToViewController(movieListVC, animated: true)
        } else {
            print("MovieListViewController가 네비게이션 스택에 없습니다.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Date and Time Pickers
    @objc private func showDatePicker() { // 날짜 데이터
        let datePickerVC = UIViewController()
        datePickerVC.modalPresentationStyle = .pageSheet
        datePickerVC.preferredContentSize = CGSize(width: view.frame.width, height: 200)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        datePickerVC.view.addSubview(datePicker)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 50)
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            self.bookingView.dateButton.setTitle(formatter.string(from: datePicker.date), for: .normal)
            datePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        datePickerVC.view.addSubview(confirmButton)
        
        // 모달 창에 커스텀 높이 적용
        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 200 }] // 전체 모달 창 높이를 200pt로 고정
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        presentWithWhiteBackground(datePickerVC, animated: true)
    }
    
    @objc private func showTimePicker() { //시간 데이터
        let timePickerVC = UIViewController()
        timePickerVC.modalPresentationStyle = .pageSheet
        timePickerVC.preferredContentSize = CGSize(width: view.frame.width, height: 200)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        timePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        timePickerVC.view.addSubview(timePicker)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 50)
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            self.bookingView.timeButton.setTitle(formatter.string(from: timePicker.date), for: .normal)
            timePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        timePickerVC.view.addSubview(confirmButton)
        
        // 모달 창에 커스텀 높이 적용
        if let sheet = timePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 200 }] // 전체 모달 창 높이를 200pt로 고정
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
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
