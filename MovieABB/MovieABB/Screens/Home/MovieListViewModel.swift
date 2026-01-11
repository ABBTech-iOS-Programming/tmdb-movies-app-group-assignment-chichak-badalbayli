//
//  File.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import UIKit

enum MovieCategory: Int, CaseIterable {
    case nowPlaying
    case popular
    case upcoming
    case topRated

    var title: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }

    var endpoint: PostsEndpoints {
        switch self {
        case .nowPlaying: return .getNowPlaying
        case .popular: return .getPopular
        case .upcoming: return .getUpcoming
        case .topRated: return .getTopRated
        }
    }
}

final class MovieListViewModel {

    private let networkService: NetworkService
    
    private(set) var trendingMovies: [MovieDTO] = []
    private(set) var movies: [MovieDTO] = []
    var currentCategory: MovieCategory = .popular

    var onStateChange: ((ViewState) -> Void)?

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func loadTrending() {
        onStateChange?(.loading)
        networkService.request(
            PostsEndpoints.getTrending(.day)
        ) { [weak self] (result: Result<MoviesResponseDTO, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.trendingMovies = response.results
                    self?.onStateChange?(.success)
                case .failure:
                    self?.onStateChange?(.error("Failed to load trending movies"))
                }
            }
        }
    }
    
    func loadMovies(category: MovieCategory) {
        currentCategory = category
        requestMovies(endpoint: category.endpoint)
    }

    private func requestMovies(endpoint: PostsEndpoints) {
        onStateChange?(.loading)
        networkService.request(endpoint) { [weak self]
            (result: Result<MoviesResponseDTO, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                    self?.onStateChange?(.success)
                case .failure:
                    self?.onStateChange?(.error("Failed to load movies"))
                }
            }
        }
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            loadMovies(category: currentCategory)
            return
        }
        onStateChange?(.loading)
        networkService.request(
            PostsEndpoints.searchMovie(query: query)
        ) { [weak self] (result: Result<MoviesResponseDTO, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                    self?.onStateChange?(.success)
                case .failure:
                    self?.onStateChange?(.error("Failed to search movies"))
                }
            }
        }
    }
}
