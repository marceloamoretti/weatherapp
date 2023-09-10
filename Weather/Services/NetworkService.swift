//
//  NetworkService.swift
//  Weather
//
//  Created by Marcelo on 2023-09-02.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case badURL
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
