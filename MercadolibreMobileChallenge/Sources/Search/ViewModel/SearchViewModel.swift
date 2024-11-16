//
//  SearchViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

enum SearchError {
    case noResults
    case transportError
    case serverError
}

protocol SearchViewModelDelegate: AnyObject {
    func didGetSucessfulSearchResults()
    func didGetError(error: SearchError)
}

protocol SearchViewModelProtocol {
    var searchResults: [Item] { get }
    var delegate: SearchViewModelDelegate? { get set }
    func search(query: String)
}

class SearchViewModel: SearchViewModelProtocol {
    var searchResults: [Item] = []
    weak var delegate: SearchViewModelDelegate?
    
    func search(query: String) {
        SearchService().getResultFor(query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.searchResults = success.results
                    if success.results.isEmpty {
                        self?.delegate?.didGetError(error: .noResults)
                        return
                    }
                    self?.delegate?.didGetSucessfulSearchResults()
                case .failure(let error):
                    self?.searchResults = []
                    var searchError: SearchError
                    if error == .transportError {
                        searchError = .transportError
                    } else {
                        searchError = .serverError
                    }
                    self?.delegate?.didGetError(error: searchError)
                }
            }
        }
    }
}
