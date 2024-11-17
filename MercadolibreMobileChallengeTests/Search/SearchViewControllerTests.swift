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
    private var spy: SearchViewModelSpy!
    private weak var delegate: SearchViewModelDelegate!

    override func setUp() {
        super.setUp()
        spy = SearchViewModelSpy()
        sut = SearchViewController(viewModel: spy)
        delegate = sut
    }

    override func tearDown() {
        super.tearDown()
        spy = nil
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut)
    }
}
