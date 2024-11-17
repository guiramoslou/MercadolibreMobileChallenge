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
}
