//
//  SearchService.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

enum SearchError: Error {
    case noResults
    case transportError
    case serverError
}

protocol SearchServiceProtocol {
    var networkProvider: NetworkProviderProtocol { get }
    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, SearchError>) -> Void)
}

final class SearchService: SearchServiceProtocol {
    let networkProvider: NetworkProviderProtocol

    init(networkProvider: NetworkProviderProtocol = NetworkProvider.shared) {
        self.networkProvider = networkProvider
    }

    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, SearchError>) -> Void) {
        guard let url = Endpoints.search(query: query).url else {
            completion(.failure(.serverError))
            return
        }
        
        networkProvider.makeApiCall(with: url) { data, response, error in
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
                completion(.failure(.serverError))
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: hasData)
                completion(.success(result))
            } catch {
                completion(.failure(.serverError))
            }
        }
    }
}
