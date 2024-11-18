//
//  ItemDetailsViewSpy.swift
//  MercadolibreMobileChallengeTests
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation
import UIKit
@testable
import MercadolibreMobileChallenge

class ItemDetailsViewSpy: UIView, ItemDetailsViewProtocol {
    var tittle = String()
    var imageUrl: URL?
    var price = String()
    var attributes: [Attribute] = []

    func setupContent(title: String, imageUrl: URL?, price: String, attributes: [Attribute]) {
        self.tittle = title
        self.imageUrl = imageUrl
        self.price = price
        self.attributes = attributes
    }
}
