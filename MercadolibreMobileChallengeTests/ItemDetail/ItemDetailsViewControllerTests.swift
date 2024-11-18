//
//  ItemDetailsViewControllerTests.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import XCTest
@testable
import MercadolibreMobileChallenge

final class ItemDetailsViewControllerTests: XCTestCase {
    private var sut: ItemDetailsViewController!
    private var viewModelSpy: ItemDetailsViewModelSpy!
    private var viewSpy: ItemDetailsViewSpy!

    override func setUp() {
        super.setUp()
        viewModelSpy = ItemDetailsViewModelSpy()
        viewSpy = ItemDetailsViewSpy()
        sut = ItemDetailsViewController(viewModel: viewModelSpy, view: viewSpy)
    }

    override func tearDown() {
        super.tearDown()
        viewModelSpy = nil
        viewSpy = nil
        sut = nil
    }

    func testLoadView() {
        sut = ItemDetailsViewController(viewModel: viewModelSpy)
        sut.loadView()
        XCTAssertEqual(sut.view.isKind(of: ItemDetailsView.self), true)
    }

    func testViewDidLoad() {
        viewModelSpy.setup(title: "Test Title",
                           price: "Test Price",
                           attributes: [
                            .init(keyName: "Test Name One", valueName: "Test Value One"),
                            .init(keyName: "Test Name Two", valueName: "Test Value Two")
                           ])
        sut.viewDidLoad()
        XCTAssertEqual(viewSpy.tittle, "Test Title")
        XCTAssertEqual(viewSpy.price, "Test Price")
        XCTAssertEqual(viewSpy.attributes[0].keyName, "Test Name One")
        XCTAssertEqual(viewSpy.attributes[0].valueName, "Test Value One")
        XCTAssertEqual(viewSpy.attributes[1].keyName, "Test Name Two")
        XCTAssertEqual(viewSpy.attributes[1].valueName, "Test Value Two")

    }
}
