//
//  NetworkProvider.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation

protocol NetworkProviderProtocol {
    func makeApiCall(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void)
}

class NetworkProvider: NetworkProviderProtocol {
    static let shared = NetworkProvider()
    
    private init() {/*don't make instances of this class, use shared instead*/}

    func makeApiCall(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}
