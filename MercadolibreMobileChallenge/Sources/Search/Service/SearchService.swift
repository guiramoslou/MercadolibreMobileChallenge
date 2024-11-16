//
//  SearchService.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol SearchServiceProtocol {
    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void)
}

class SearchService: SearchServiceProtocol {
    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MLB/search?q=\(query)") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let hasError = error {
                completion(.failure(.transportError(hasError)))
                return
            }
            
            if let hasResponse = response as? HTTPURLResponse,
               !(200...299).contains(hasResponse.statusCode) {
                completion(.failure(.serverError(statusCode: hasResponse.statusCode)))
                return
            }
            
            guard let hasData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: hasData)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidUrl
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}
