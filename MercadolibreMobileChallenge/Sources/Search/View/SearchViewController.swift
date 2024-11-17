//
//  SearchViewController.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class SearchViewController: UIViewController {

    private let searchView = SearchView(frame: UIScreen.main.bounds)
    private let viewModel: SearchViewModelProtocol

    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        searchView.setupDelegates(searchBarDelegate: self,
                                  tableviewDelegate: self,
                                  tableViewDataSource: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = searchView
    }

    private func handleError(_ error: SearchError) {
        var errorMessage = Localize.genericError.localizedString()
        switch error {
        case .noResults:
            errorMessage = Localize.noResultError.localizedString()
        case .transportError:
            errorMessage = Localize.transportError.localizedString()
        case .serverError:
            errorMessage = Localize.serverError.localizedString()
        }
        searchView.showError(errorMessage)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell
        let model = viewModel.searchResults[indexPath.row]
        cell?.setup(imageUrl: model.imageUrl, title: model.title, price: model.price.localizedCurrency())
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.searchResults[indexPath.row]
        let itemDetailViewModel = ItemDetailsViewModel(item: model)
        let itemDetailViewController = ItemDetailsViewViewController(viewModel: itemDetailViewModel)
        navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let hasText = searchBar.text else {
            return
        }
        searchView.startLoading()
        viewModel.search(query: hasText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didGetSuccessfulSearchResults() {
        searchView.stopLoading()
    }

    func didGetError(_ error: SearchError) {
        searchView.stopLoading()
        handleError(error)
    }
}
