//
//  TrendingModel.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import Foundation

struct MoviesResponseDTO: Decodable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
