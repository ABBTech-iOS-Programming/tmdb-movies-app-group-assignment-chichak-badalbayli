//
//  PostsEndpoints.swift
//  Posts
//
//  Created by Chichek on 27.12.25.
//

import Foundation

enum PostsEndpoints {
}

extension PostsEndpoints: Endpoint {
    var baseURL: String {
        return "https://developer.themoviedb.org/reference"
    }
    var path: String {
        switch self {
        }
    }
    var method: HttpMethod {
        return .get
    }
    var headers: [String : String]? {
        return nil
    }
    var queryItems: [URLQueryItem]? {
        return nil
    }
    var httpBody: (any Encodable)? {
        return nil
    }
}

