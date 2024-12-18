//
//  MovieResponseModel.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
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

