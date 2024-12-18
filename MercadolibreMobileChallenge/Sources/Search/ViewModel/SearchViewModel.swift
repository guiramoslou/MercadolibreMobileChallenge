//
//  SearchViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didGetSuccessfulSearchResults()
    func didGetError(_ error: SearchError)
}

protocol SearchViewModelProtocol {
    var searchResults: [Item] { get }
    func search(query: String)
}

final class SearchViewModel: SearchViewModelProtocol {
    private let service: SearchServiceProtocol
    var searchResults: [Item] = []
    weak var delegate: SearchViewModelDelegate?
    
    init(service: SearchServiceProtocol) {
        self.service = service
    }
    
    func search(query: String) {
        service.getResultFor(query) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let successfulResult):
                    self?.handleResult(successfulResult)
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    private func handleResult(_ result: SearchResult) {
        searchResults = result.items
        if result.items.isEmpty {
            delegate?.didGetError(.noResults)
            return
        }
        delegate?.didGetSuccessfulSearchResults()
    }
    
    private func handleError(_ error: SearchError) {
        searchResults = []
        delegate?.didGetError(error)
    }
}
