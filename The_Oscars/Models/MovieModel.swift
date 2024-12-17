//
//  MovieModel.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation

// MARK: - 최상위 API 응답 모델
struct MovieResponse: Codable {
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
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
    let maximum: String
    let minimum: String
}

// MARK: - 영화 데이터 모델
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
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
