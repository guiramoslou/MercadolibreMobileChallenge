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
    var didCallGetResult = 0
    var getResultValue = String()
    var error: NetworkError? = nil
    var result: SearchResult? = nil

    func getResultFor(_ query: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        didCallGetResult += 1
        getResultValue = query
        if let hasError = error {
            completion(.failure(hasError))
            return
        }
        guard let hasResult = result else {
            completion(.failure(.noData))
            return
        }
        completion(.success(hasResult))
    }

    func setup(error: NetworkError? = nil, result: SearchResult? = nil) {
        self.error = error
        self.result = result
    }
}
