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
              let date = bookingView.dateButton.title(for: .normal),
              let time = bookingView.timeButton.title(for: .normal),
              !date.isEmpty, !time.isEmpty else {
            showAlert(message: "날짜와 시간을 선택해주세요!")
            return
        }

        let totalPrice = peopleCount * 5000
        let booking = Booking(movieName: movieName, date: date, time: time, peopleCount: peopleCount, totalPrice: totalPrice)

        UserDefaultsManager.shared.saveBooking(booking)
        print("예매 정보가 저장되었습니다: \(booking)")

        // TabBarViewController로 이동
        navigateToTabBar()
    }

    // TabBarViewController로 이동하는 메서드
    private func navigateToTabBar() {
        let tabBarVC = TabBarViewController()
        // 네비게이션 스택 초기화 및 TabBarViewController 설정
            if let navigationController = navigationController {
                navigationController.setViewControllers([tabBarVC], animated: true)
            } else {
                // 네비게이션 컨트롤러가 없을 경우 모달로 표시
                tabBarVC.modalPresentationStyle = .fullScreen
                present(tabBarVC, animated: true, completion: nil)
            }
        }
    
    // Alert 메시지 표시 메서드
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
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
        
        // 확인 버튼 컨테이너 뷰
        let confirmContainerView = UIView()
        confirmContainerView.backgroundColor = .white
        confirmContainerView.translatesAutoresizingMaskIntoConstraints = false

        // 확인 버튼
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.blue, for: .normal) // 텍스트 색상
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            self.bookingView.dateButton.setTitle(formatter.string(from: datePicker.date), for: .normal)
            datePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)

        // 버튼을 컨테이너 뷰에 추가
        confirmContainerView.addSubview(confirmButton)

        // 컨테이너 뷰와 버튼을 datePickerVC에 추가
        datePickerVC.view.addSubview(confirmContainerView)

        // AutoLayout 설정
        NSLayoutConstraint.activate([
            // datePicker의 아래에 confirmContainerView 배치
            confirmContainerView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            confirmContainerView.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor),
            confirmContainerView.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor),
            confirmContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            // confirmButton을 컨테이너에 꽉 채움
            confirmButton.topAnchor.constraint(equalTo: confirmContainerView.topAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: confirmContainerView.bottomAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: confirmContainerView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: confirmContainerView.trailingAnchor)
        ])
        
        // 모달 창에 커스텀 높이 적용
        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 200 }] // 전체 모달 창 높이를 200pt로 고정
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        presentWithWhiteBackground(datePickerVC, animated: true)
    }
    
    @objc private func showTimePicker() {
        let timePickerVC = UIViewController()
        timePickerVC.modalPresentationStyle = .pageSheet
        timePickerVC.preferredContentSize = CGSize(width: view.frame.width, height: 250)
        
        // 시간 선택용 UIDatePicker
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePickerVC.view.addSubview(timePicker)
        
        // 확인 버튼 컨테이너 뷰
        let confirmContainerView = UIView()
        confirmContainerView.backgroundColor = .white
        confirmContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 확인 버튼
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.blue, for: .normal) // 텍스트 색상
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addAction(UIAction(handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            self.bookingView.timeButton.setTitle(formatter.string(from: timePicker.date), for: .normal)
            timePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        
        // 버튼을 컨테이너 뷰에 추가
        confirmContainerView.addSubview(confirmButton)
        timePickerVC.view.addSubview(confirmContainerView)
        
        // AutoLayout 설정
        NSLayoutConstraint.activate([
            // timePicker의 상단 배치
            timePicker.topAnchor.constraint(equalTo: timePickerVC.view.topAnchor),
            timePicker.leadingAnchor.constraint(equalTo: timePickerVC.view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: timePickerVC.view.trailingAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 150),
            
            // timePicker 아래에 confirmContainerView 배치
            confirmContainerView.topAnchor.constraint(equalTo: timePicker.bottomAnchor),
            confirmContainerView.leadingAnchor.constraint(equalTo: timePickerVC.view.leadingAnchor),
            confirmContainerView.trailingAnchor.constraint(equalTo: timePickerVC.view.trailingAnchor),
            confirmContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            // confirmButton을 컨테이너에 꽉 채움
            confirmButton.topAnchor.constraint(equalTo: confirmContainerView.topAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: confirmContainerView.bottomAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: confirmContainerView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: confirmContainerView.trailingAnchor)
        ])
        
        // 모달 설정
        if let sheet = timePickerVC.sheetPresentationController {
            sheet.detents = [.custom { _ in 200 }] // 높이 250으로 고정
            sheet.prefersGrabberVisible = true // 상단 핸들 표시
            sheet.preferredCornerRadius = 20   // 상단 라운드 처리
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
