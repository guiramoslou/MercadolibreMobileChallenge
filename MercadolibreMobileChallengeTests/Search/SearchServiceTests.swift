//
//  SearchServiceTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class SearchServiceTests: XCTestCase {
    private var sut: SearchService!
    private var spy: NetworkProviderSpy!
    
    override func setUp() {
        super.setUp()
        spy = NetworkProviderSpy()
        sut = SearchService(networkProvider: spy)
    }

    override func tearDown() {
        super.tearDown()
        spy = nil
        sut = nil
    }

    func testGetResultForQuery() {
        let expectation = XCTestExpectation(description: "testGetResultForQuery")
        spy.setup(jsonName: .iPhoneQuery)
        sut.getResultFor(String()) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("found an unexpected error: \(failure)")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testFailureGetResultForQuery() {
        let expectation = XCTestExpectation(description: "testGetResultForQuery")
        spy.setup(error: SearchError.transportError)
        sut.getResultFor(String()) { result in
            switch result {
            case .success(_):
                XCTFail("found success while expecting failure")
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertEqual(failure, .transportError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testFailureGetResultForQueryNoData() {
        let expectation = XCTestExpectation(description: "testGetResultForQuery")
        spy.setup(jsonName: nil, urlResponse: nil, error: nil)
        sut.getResultFor(String()) { result in
            switch result {
            case .success(let success):
                debugPrint(success)
                XCTFail("found success while expecting failure")
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertEqual(failure, .serverError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
