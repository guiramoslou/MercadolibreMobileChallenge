//
//  ItemDetailsViewModelSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation
@testable
import MercadolibreMobileChallenge

class ItemDetailsViewModelSpy: ItemDetailsViewModelProtocol {
    var title = String()
    var imageUrl: URL?
    var price = String()
    var attributes: [Attribute] = []

    func setup(title: String, imageUrl: URL? = nil, price: String, attributes: [Attribute]) {
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.attributes = attributes
    }
}
