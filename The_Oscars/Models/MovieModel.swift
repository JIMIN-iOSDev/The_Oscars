//
//  MovieModel.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation

// MARK: - 최상위 API 응답 모델
struct MovieResponse: Codable {
    let dates: Dates?              // 날짜 범위 (옵션, now_playing 및 upcoming에만 존재)
    let page: Int                  // 현재 페이지
    let results: [Movie]           // 영화 목록
    let totalPages: Int            // 전체 페이지 수
    let totalResults: Int          // 전체 결과 수
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - 날짜 범위 모델
struct Dates: Codable {
    let maximum: String            // 최대 날짜
    let minimum: String            // 최소 날짜
}

// MARK: - 영화 데이터 모델
struct Movie: Codable {
    let adult: Bool                // 성인 영화 여부
    let backdropPath: String?      // 배경 이미지 경로
    let genreIds: [Int]?           // 장르 ID 배열
    let id: Int                    // 영화 ID
    let originalLanguage: String?  // 원래 언어
    let originalTitle: String?     // 원제목
    let overview: String?          // 줄거리
    let popularity: Double?        // 인기 점수
    let posterPath: String?        // 포스터 이미지 경로
    let releaseDate: String?       // 개봉일
    let title: String?             // 제목
    let video: Bool?               // 비디오 여부
    let voteAverage: Double?       // 평균 평점
    let voteCount: Int?            // 투표 수
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
