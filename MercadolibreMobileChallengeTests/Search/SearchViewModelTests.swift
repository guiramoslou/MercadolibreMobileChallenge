//
//  SearchViewModelTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 16/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class SearchViewModelTests: XCTestCase {
    private var sut: SearchViewModel!
    private var spy: SearchServiceSpy!
    private var successDelegateCalled = 0
    private var errorReturned: SearchError?
    private let testSearchSuccessExpectation = XCTestExpectation(description: "testSearchSuccess")
    private let testSearchFailureExpectation = XCTestExpectation(description: "testSearchFailure")
    
    
    override func setUp() {
        super.setUp()
        spy = SearchServiceSpy()
        sut = SearchViewModel(service: spy)
        sut.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        spy = nil
        sut = nil
        successDelegateCalled = 0
        errorReturned = nil
    }
    
    func testSearchSuccess() {
        spy.setup(result: SearchResult(query: String(),
                                       items: [Item(title: String(),
                                                    imageUrl: nil,
                                                    price: Double(),
                                                    attributes: nil)]))
        let query = "test query"
        sut.search(query: query)
        XCTAssertEqual(spy.didCallGetResult, 1)
        XCTAssertEqual(spy.getResultValue, "test query")
        wait(for: [testSearchSuccessExpectation], timeout: 10.0)
        XCTAssertEqual(successDelegateCalled, 1)
        XCTAssertNil(errorReturned)
    }

    func testSearchEmptyResult() {
        spy.setup(result: SearchResult(query: String(),
                                       items: []))
        let query = "test query"
        sut.search(query: query)
        XCTAssertEqual(spy.didCallGetResult, 1)
        XCTAssertEqual(spy.getResultValue, "test query")
        wait(for: [testSearchFailureExpectation], timeout: 10.0)
        XCTAssertEqual(successDelegateCalled, 0)
        XCTAssertEqual(errorReturned, .noResults)
    }
    
    func testSearchFailure() {
        spy.setup(error: .serverError)
        let query = "test query"
        sut.search(query: query)
        XCTAssertEqual(spy.didCallGetResult, 1)
        XCTAssertEqual(spy.getResultValue, "test query")
        wait(for: [testSearchFailureExpectation], timeout: 10.0)
        XCTAssertEqual(successDelegateCalled, 0)
        XCTAssertEqual(.serverError, errorReturned)
    }

    func testSearchFailureTransportError() {
        spy.setup(error: .transportError)
        let query = "test query"
        sut.search(query: query)
        XCTAssertEqual(spy.didCallGetResult, 1)
        XCTAssertEqual(spy.getResultValue, "test query")
        wait(for: [testSearchFailureExpectation], timeout: 10.0)
        XCTAssertEqual(successDelegateCalled, 0)
        XCTAssertEqual(.transportError, errorReturned)
    }
}

extension SearchViewModelTests: SearchViewModelDelegate {
    func didGetSuccessfulSearchResults() {
        successDelegateCalled += 1
        testSearchSuccessExpectation.fulfill()
    }
    
    func didGetError(_ error: SearchError) {
        errorReturned = error
        testSearchFailureExpectation.fulfill()
    }
}
