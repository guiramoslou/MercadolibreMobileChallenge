//
//  ItemDetailsViewTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class ItemDetailsViewTests: XCTestCase {
    private var sut: ItemDetailsView!

    override func setUp() {
        super.setUp()
        sut = ItemDetailsView(frame: UIScreen.main.bounds)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInit() {
        sut.setupContent(title: "Test Title",
                         imageUrl: nil,
                         price: "Test Price",
                         attributes: [Attribute(keyName: "Test Key Name",
                                                valueName: "Test Key Value")])
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.backgroundColor, .white)
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.subviews.first?.isKind(of: UIScrollView.self), true)
    }
}
