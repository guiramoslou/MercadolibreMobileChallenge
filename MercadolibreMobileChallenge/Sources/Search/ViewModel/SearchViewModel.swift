//
//  SearchViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didGetSucessfulSearchResults()
    func didGetError()
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
                    self?.delegate?.didGetSucessfulSearchResults()
                case .failure(let failure):
                    debugPrint(failure)
                    self?.delegate?.didGetError()
                }
            }
        }
    }
}
