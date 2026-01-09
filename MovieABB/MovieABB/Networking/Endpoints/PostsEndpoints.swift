//
//  PostsEndpoints.swift
//  Posts
//
//  Created by Chichek on 27.12.25.
//

import Foundation

enum TimeWindow: String {
    case day
    case week
}

enum TMDBConfig {
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZDFhN2VjNmZiOTgwMGRjMjc5MGNlM2QzOGE0NDgzNCIsIm5iZiI6MTcyMDc2OTIyNC40NzcsInN1YiI6IjY2OTBkYWM4NjM2YzQyN2EwNzllMjIwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nYR4ZxuE5P6FjboapjUgIWRQSEKv5YdBlzyaGppiJDM"
    static let baseURL = "https://api.themoviedb.org"
}

enum PostsEndpoints {
    case getTrending(TimeWindow)
    case getNowPlaying
    case getPopular
    case getUpcoming
    case getTopRated
    case searchMovie(query: String)
}

extension PostsEndpoints: Endpoint {
    var baseURL: String {
        return TMDBConfig.baseURL
    }
    var path: String {
        switch self {
        case .getTrending(let timeWindow):
            return "/3/trending/movie/\(timeWindow.rawValue)"
        case .getNowPlaying:
            return "/3/movie/now_playing"
        case .getPopular:
            return "/3/movie/popular"
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    var method: HttpMethod {
        return .get
    }
    var headers: [String : String] {
        [
            "Authorization": "Bearer \(TMDBConfig.accessToken)",
            "accept": "application/json"
        ]
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMovie(let query):
            return [
                URLQueryItem(name: "query", value: query)
            ]
        default:
            return nil
        }
    }
    var httpBody: (any Encodable)? {
        return nil
    }
}

