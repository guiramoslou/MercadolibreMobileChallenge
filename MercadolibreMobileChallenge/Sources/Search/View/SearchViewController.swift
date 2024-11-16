//
//  SearchViewController.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

class SearchViewController: UIViewController {

    private let searchView = SearchView(frame: UIScreen.main.bounds)
    private let viewModel = SearchViewModel() // TODO: - dependency injection

    override func loadView() {
        super.loadView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchBar.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        viewModel.delegate = self
    }

    private func handleError(_ error: SearchError) {
        switch error {
        case .noResults:
            searchView.noResultsView.text = "No results found"
            searchView.noResultsView.isHidden = false
        case .transportError:
            searchView.noResultsView.text = "Transport error"
            searchView.noResultsView.isHidden = false
        case .serverError:
            searchView.noResultsView.text = "Server error"
            searchView.noResultsView.isHidden = false
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell
        let model = viewModel.searchResults[indexPath.row]
        cell?.setup(imageUrl: model.thumbnail, title: model.title, price: String(model.price))
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.searchResults[indexPath.row]
        let itemDetailViewModel = ItemDetailsViewModel(item: model)
        let detailViewController = ItemDetailsViewViewController(viewModel: itemDetailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let hasText = searchBar.text else {
            return
        }
        searchView.isUserInteractionEnabled = false
        searchView.activityIndicatorView.startAnimating()
        searchView.activityIndicatorView.isHidden = false
        searchView.noResultsView.isHidden = true
        searchView.tableView.isHidden = false
        viewModel.search(query: hasText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didGetSucessfulSearchResults() {
        searchView.tableView.reloadData()
        searchView.activityIndicatorView.stopAnimating()
        searchView.activityIndicatorView.isHidden = true
        searchView.isUserInteractionEnabled = true
    }
    
    func didGetError(error: SearchError) {
        searchView.tableView.reloadData()
        searchView.activityIndicatorView.stopAnimating()
        searchView.activityIndicatorView.isHidden = true
        searchView.isUserInteractionEnabled = true
        handleError(error)
    }
}
