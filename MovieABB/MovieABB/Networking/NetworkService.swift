//
//  NetworkService.swift
//  Posts
//
//  Created by Chichek on 27.12.25.
//

import Foundation

protocol  NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
        
    }
   
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let createRequest = endpoint.makeRequest()
        switch createRequest {
        case .success(let request):
            session.dataTask(with: request) { data, response, error in
                if let error {
                    DispatchQueue.main.async {
                        completion(.failure(.unknown(error)))
                    }
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    guard (200...299).contains(statusCode) else {
                        DispatchQueue.main.async {
                            completion(.failure(.serverError(statusCode: statusCode)))
                        }
                        return
                    }
                }
                guard let data else {
                    DispatchQueue.main.async {
                        completion(.failure(.noData))
                    }
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            }.resume()
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
