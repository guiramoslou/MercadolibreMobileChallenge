//
//  SearchViewSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation
import UIKit
@testable
import MercadolibreMobileChallenge

class SearchViewSpy: UIView, SearchViewProtocol {
    var setupDelegatesCalled = 0
    var searchBarDelegate: UISearchBarDelegate?
    var tableviewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?
    var errorMessage = String()
    var startLoadingCalled = 0
    var stopLoadingCalled = 0
    lazy var searchBar: UISearchBar = {
        UISearchBar()
    }()

    func setupDelegates(searchBarDelegate: any UISearchBarDelegate,
                        tableviewDelegate: any UITableViewDelegate,
                        tableViewDataSource: any UITableViewDataSource) {
        setupDelegatesCalled += 1
        self.searchBarDelegate = searchBarDelegate
        self.tableviewDelegate = tableviewDelegate
        self.tableViewDataSource = tableViewDataSource
    }

    func showError(_ message: String) {
        errorMessage = message
    }

    func startLoading() {
        startLoadingCalled += 1
    }

    func stopLoading() {
        stopLoadingCalled += 1
    }
}
