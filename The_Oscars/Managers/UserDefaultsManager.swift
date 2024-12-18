//
//  UserDefaultManager.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private let userKey = "users"
    private let loggedInUserKey = "loggedInUser"
    private let bookingKey = "bookings" // 예매 데이터를 저장할 키
    
    private init() {}
    
    // 로그인
    func loginUser(id: String, password: String) -> Bool {
        if let data = defaults.data(forKey: userKey),
           let users = try? JSONDecoder().decode([UserModel].self, from: data),
           let user = users.first(where: { $0.id == id && $0.password == password }) {
            
            if let encodedUser = try? JSONEncoder().encode(user) {
                defaults.set(encodedUser, forKey: loggedInUserKey)
            }
            return true
        }
        return false
    }
    
    // 회원가입
    func signupUser(_ user: UserModel) -> Bool {
        var users: [UserModel] = []
        
        if let data = defaults.data(forKey: userKey),
           let loadedUsers = try? JSONDecoder().decode([UserModel].self, from: data) {
            users = loadedUsers
        }
        
        users.append(user)
        if let encoded = try? JSONEncoder().encode(users) {
            defaults.set(encoded, forKey: userKey)
            return true
        }
        return false
    }
    
    // 아이디 중복 체크
    func isUserIdDuplicated(_ id: String) -> Bool {
        if let data = defaults.data(forKey: userKey),
           let users = try? JSONDecoder().decode([UserModel].self, from: data) {
            return users.contains(where: { $0.id == id })
        }
        return false
    }
    
    // 마이페이지
    func getLoggedInUser() -> UserModel? {
        if let data = defaults.data(forKey: loggedInUserKey),
           let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            return user
        }
        return nil
    }
    
    // 로그아웃
    func logoutUser() {
        defaults.removeObject(forKey: loggedInUserKey)
    }
    
    // MARK: - 예매 데이터 저장
    func saveBooking(_ booking: Booking) {
        var bookings: [Booking] = []
        
        // 기존 저장된 데이터 가져오기
        if let data = defaults.data(forKey: bookingKey),
           let savedBookings = try? JSONDecoder().decode([Booking].self, from: data) {
            bookings = savedBookings
        }
        
        // 새로운 데이터 추가
        bookings.append(booking)
        
        // 저장
        if let encoded = try? JSONEncoder().encode(bookings) {
            defaults.set(encoded, forKey: bookingKey)
        }
    }
    
    // MARK: - 예매 데이터 불러오기
    func getBookings() -> [Booking] {
        if let data = defaults.data(forKey: bookingKey),
           let bookings = try? JSONDecoder().decode([Booking].self, from: data) {
            return bookings
        }
        return []
    }
}
