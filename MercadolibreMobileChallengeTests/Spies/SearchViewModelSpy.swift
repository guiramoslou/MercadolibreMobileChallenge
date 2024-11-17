//
//  SearchViewModelSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation
@testable
import MercadolibreMobileChallenge

class SearchViewModelSpy: SearchViewModelProtocol {
    var searchResults: [Item] = []
    var searchQuery = String()
    var searchQueryCalled = 0
    
    func search(query: String) {
        searchQueryCalled += 1
        searchQuery = query
    }

    func setup(with items: [Item]) {
        searchResults = items
    }
}
