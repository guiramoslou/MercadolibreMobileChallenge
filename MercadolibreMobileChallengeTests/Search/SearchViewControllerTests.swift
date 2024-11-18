//
//  SearchViewControllerTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class SearchViewControllerTests: XCTestCase {
    private var sut: SearchViewController!
    private var viewModelSpy: SearchViewModelSpy!
    private var searchViewSpy: SearchViewSpy!
    private weak var delegate: SearchViewModelDelegate!

    override func setUp() {
        super.setUp()
        viewModelSpy = SearchViewModelSpy()
        searchViewSpy = SearchViewSpy()
        sut = SearchViewController(viewModel: viewModelSpy, view: searchViewSpy)
        delegate = sut
    }

    override func tearDown() {
        super.tearDown()
        viewModelSpy = nil
        searchViewSpy = nil
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(searchViewSpy.setupDelegatesCalled, 1)
    }

    func testHandleErrorNoResults() {
        let expected = Localize.noResultError.localizedString()
        delegate.didGetError(.noResults)
        XCTAssertEqual(searchViewSpy.stopLoadingCalled, 1)
        XCTAssertEqual(searchViewSpy.errorMessage, expected)
    }

    func testHandleErrorTransportError() {
        let expected = Localize.transportError.localizedString()
        delegate.didGetError(.transportError)
        XCTAssertEqual(searchViewSpy.stopLoadingCalled, 1)
        XCTAssertEqual(searchViewSpy.errorMessage, expected)
    }

    func testHandleErrorServerError() {
        let expected = Localize.serverError.localizedString()
        delegate.didGetError(.serverError)
        XCTAssertEqual(searchViewSpy.errorMessage, expected)
    }

    func testStartLoading() {
        searchViewSpy.searchBarDelegate?.searchBarSearchButtonClicked?(searchViewSpy.searchBar)
        XCTAssertEqual(searchViewSpy.startLoadingCalled, 1)
    }

    func testStopLoading() {
        searchViewSpy.searchBarDelegate?.searchBarSearchButtonClicked?(searchViewSpy.searchBar)
        delegate.didGetSuccessfulSearchResults()
        XCTAssertEqual(searchViewSpy.stopLoadingCalled, 1)
    }
}
