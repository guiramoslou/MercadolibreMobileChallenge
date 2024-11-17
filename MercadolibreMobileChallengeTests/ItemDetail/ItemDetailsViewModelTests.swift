//
//  ItemDetailsViewModelTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class ItemDetailsViewModelTests: XCTestCase {
    private var sut: ItemDetailsViewModel!

    override func setUp() {
        super.setUp()
        sut = ItemDetailsViewModel(item: Item(title: String(),
                                              imageUrl: nil,
                                              price: Double(),
                                              attributes: nil))
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInit() {
        let title = "Test Title"
        let imageUrl = URL(string: "http://testwebsitename.com/testfilename.jpg")
        let price = 99.99
        let attributes = [
            Attribute(keyName: "Attribute One Key", valueName: "Attribute One Value"),
            Attribute(keyName: "Attribute Two Key", valueName: "Attribute Two Value")
        ]
        let item = Item(title: title, imageUrl: imageUrl, price: price, attributes: attributes)
        sut = ItemDetailsViewModel(item: item)
        XCTAssertEqual(sut.title, "Test Title")
        XCTAssertEqual(sut.imageUrl?.absoluteString, "http://testwebsitename.com/testfilename.jpg")
        debugPrint(sut.price)
        XCTAssertEqual(sut.price, "R$ 99,99")
        XCTAssertEqual(sut.attributes[0].keyName, "Attribute One Key")
        XCTAssertEqual(sut.attributes[0].valueName, "Attribute One Value")
        XCTAssertEqual(sut.attributes[1].keyName, "Attribute Two Key")
        XCTAssertEqual(sut.attributes[1].valueName, "Attribute Two Value")
    }
}
