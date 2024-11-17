//
//  SearchResultCellTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class SearchResultCellTests: XCTestCase {
    private var sut: SearchResultCell!
    
    override func setUp() {
        super.setUp()
        sut = SearchResultCell(style: .default, reuseIdentifier: SearchResultCell.reuseIdentifier)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut)
    }
}
