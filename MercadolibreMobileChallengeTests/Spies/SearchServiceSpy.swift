//
//  SearchServiceSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 16/11/24.
//

import Foundation
@testable
import MercadolibreMobileChallenge

final class SearchServiceSpy: SearchServiceProtocol {
    var networkProvider: NetworkProviderProtocol
    var didCallGetResult = 0
    var getResultValue = String()
    var error: SearchError? = nil
    var result: SearchResult? = nil

    init(networkProvider: NetworkProviderProtocol = NetworkProviderSpy()) {
        self.networkProvider = networkProvider
    }

    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, SearchError>) -> Void) {
        didCallGetResult += 1
        getResultValue = query
        if let hasError = error {
            completion(.failure(hasError))
            return
        }
        guard let hasResult = result else {
            completion(.failure(.serverError))
            return
        }
        completion(.success(hasResult))
    }

    func setup(error: SearchError? = nil, result: SearchResult? = nil) {
        self.error = error
        self.result = result
    }
}
