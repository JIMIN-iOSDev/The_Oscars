//
//  NetworkManager.swift
//  The_Oscars
//
//  Created by eden on 12/17/24.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let apiKey = "b127557d8c2730fd80004f6c7279157e"
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    
    private init() {}
    
    func fetchMovies(category: MovieCategory, page: Int = 1, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let url = "\(baseURL)\(category.rawValue)"
        let parameters: [String: String] = [
            "api_key": apiKey,
            "language": "ko-KR",
            "page": "\(page)"
        ]
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    completion(.success(movieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
