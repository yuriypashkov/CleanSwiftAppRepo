//
//  NetworkService.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private lazy var urlSession: URLSession = {
        return URLSession.init(configuration: .default)
    }()
    
    func getBeers(completion: @escaping (Result<[BeerData], Error>) -> Void) {
        guard let url = URL(string: NetworkConfiguration.apiUrl) else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 400 else {
                completion(.failure(NetworkError.failedResponse))
                return
            }
            
            do {
                let beersResponse = try JSONDecoder().decode([BeerData].self, from: data)
                completion(.success(beersResponse))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        dataTask.resume()
    }
}

enum NetworkError: Error {
    case noData
    case failedResponse
    case decodingError
}
