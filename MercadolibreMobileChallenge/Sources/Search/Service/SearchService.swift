//
//  SearchService.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case transportError
    case serverError
    case noData
    case decodingError
}

protocol SearchServiceProtocol {
    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void)
}

final class SearchService: SearchServiceProtocol {
    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        guard let url = Endpoints.search(query: query).url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.transportError))
                return
            }
            
            if let hasResponse = response as? HTTPURLResponse,
               !(200...299).contains(hasResponse.statusCode) {
                completion(.failure(.serverError))
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
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
