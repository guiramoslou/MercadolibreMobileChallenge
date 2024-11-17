//
//  NetworkProviderSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation
@testable
import MercadolibreMobileChallenge

enum JsonFakeName: String {
    case iPhoneQuery = "iphonequery"
}

class NetworkProviderSpy: NetworkProviderProtocol {
    var makeApiCallCalled = 0
    var jsonName: String?
    var urlResponse: URLResponse?
    var error: Error?
    
    func makeApiCall(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) {
        makeApiCallCalled += 1
        DispatchQueue.main.async { [weak self] in
            let data = self?.turnLocalJsonIntoData()
            completionHandler(data, self?.urlResponse, self?.error)
        }
    }
    
    func setup(jsonName: JsonFakeName? = nil, urlResponse: URLResponse? = nil, error: Error? = nil) {
        self.urlResponse = urlResponse
        self.error = error
        self.jsonName = jsonName?.rawValue
    }
    
    private func turnLocalJsonIntoData() -> Data? {
        let currentBundle = Bundle(for: type(of: self))
        guard let hasJsonName = jsonName,
              let path = currentBundle.path(forResource: hasJsonName, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            self.error = error
            return nil
        }
    }
}
