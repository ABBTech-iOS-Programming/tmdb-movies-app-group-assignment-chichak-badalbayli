//
//  File.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

final class MovieListViewModel {

    private let networkService: NetworkService

    private(set) var trendingMovies: [MovieDTO] = []

    var onDataReload: (() -> Void)?
    var onError: ((NetworkError) -> Void)?

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func loadTrending() {
        networkService.request(
            PostsEndpoints.getTrending(.day)
        ) { [weak self] (result: Result<TrendingResponseDTO, NetworkError>) in
            switch result {
            case .success(let response):
                self?.trendingMovies = response.results
                self?.onDataReload?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
