//
//  MovieCategory.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import Foundation

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    
    var urlPath: String {
        return "https://api.themoviedb.org/3/movie/\(self.rawValue)"
    }
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }
}
