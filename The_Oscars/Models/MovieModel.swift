//
//  MovieModel.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
}
