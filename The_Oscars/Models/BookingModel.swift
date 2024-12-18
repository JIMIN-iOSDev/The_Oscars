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
