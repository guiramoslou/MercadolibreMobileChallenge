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
    private var spy: ItemDetailsViewModelSpy!

    override func setUp() {
        super.setUp()
        spy = ItemDetailsViewModelSpy()
        sut = ItemDetailsViewController(viewModel: spy)
    }

    override func tearDown() {
        super.tearDown()
        spy = nil
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut)
    }

    func testLoadView() {
        sut.loadView()
        XCTAssertEqual(sut.view.isKind(of: ItemDetailsView.self), true)
    }

    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut)
    }
}
