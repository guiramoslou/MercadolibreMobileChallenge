//
//  SearchService.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol SearchServiceProtocol {
    func getResultFor(_ query: String, completionHandler: @escaping (Result<SearchResult, SearchError>) -> Void)
}

class SearchService: SearchServiceProtocol {
    func getResultFor(_ query: String, completionHandler: @escaping (Result<SearchResult, SearchError>) -> Void) {
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MLB/search?q=\(query)") else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let hasData = data else {
                completionHandler(.failure(.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: hasData)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.decodingError))
            }
        }
        task.resume()
    }
}

enum SearchError: Error {
    case invalidUrl
    case noData
    case decodingError
}
