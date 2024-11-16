//
//  SearchView.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class SearchView: UIView {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.backgroundColor = .white
        activity.isHidden = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for products" // TODO: - implement localizable
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var noResultsView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .body)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupDelegates(searchBarDelegate: UISearchBarDelegate,
                        tableviewDelegate: UITableViewDelegate,
                        tableViewDataSource: UITableViewDataSource) {
        searchBar.delegate = searchBarDelegate
        tableView.delegate = tableviewDelegate
        tableView.dataSource = tableViewDataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startLoading() {
        isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        noResultsView.isHidden = true
    }

    func stopLoading() {
        tableView.reloadData()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        isUserInteractionEnabled = true
    }

    func showError(_ message: String) {
        noResultsView.text = message
        noResultsView.isHidden = false
    }
}

extension SearchView: ViewCode {
    func addSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(activityIndicatorView)
        addSubview(noResultsView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            activityIndicatorView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .white
    }
}
