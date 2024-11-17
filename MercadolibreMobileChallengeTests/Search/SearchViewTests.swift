//
//  SearchViewTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class SearchViewTests: XCTestCase {
    private var sut: SearchView!

    override func setUp() {
        super.setUp()
        sut = SearchView(frame: UIScreen.main.bounds)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut)
    }

    func testBackGroundColor() {
        XCTAssertEqual(sut.backgroundColor, .white)
    }

    func testStartLoading() {
        sut.startLoading()
        XCTAssertFalse(sut.isUserInteractionEnabled)
    }

    func testStopLoading() {
        sut.stopLoading()
        XCTAssertTrue(sut.isUserInteractionEnabled)
    }
}
