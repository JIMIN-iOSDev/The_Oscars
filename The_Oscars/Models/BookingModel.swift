//
//  BookingModel.swift
//  The_Oscars
//
//  Created by sol on 12/18/24.
//

struct Booking: Codable {
    let movieName: String
    let date: String
    let peopleCount: Int
    let totalPrice: Int
    
    init(movieName: String, date: String, peopleCount: Int, totalPrice: Int) {
        self.movieName = movieName
        self.date = date
        self.peopleCount = peopleCount
        self.totalPrice = totalPrice
    }
}

// 저장한 데이터 마이페이지로 호출
// let bookings = UserDefaultsManager.shared.getBookings()
// bookings.forEach { booking in
  //  print("영화명: \(booking.movieName), 날짜: \(booking.date), 인원: \(booking.peopleCount), 총 가격: \(booking.totalPrice)원")
// }


// 모든 모달을 닫아야 할 때
// view.window?.rootViewController?.dismiss(animated: true, completion: nil)


//예매 페이지와 모달 연결
// @objc private func bookingButtonTapped() {
//    let bookingVC = MovieBookingViewController()
//    bookingVC.movie = self.movie // 현재 영화 데이터 전달
//    let navigationController = UINavigationController(rootViewController: bookingVC)
//    navigationController.modalPresentationStyle = .fullScreen
//    present(navigationController, animated: true)
//}
