//
//  ItemDetailsViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol ItemDetailsViewModelProtocol {
    var title: String { get }
    var imageUrl: URL? { get }
    var price: String { get }
    var attributes: [Attribute] { get }
}

final class ItemDetailsViewModel: ItemDetailsViewModelProtocol {
    let title: String
    let imageUrl: URL?
    let price: String
    let attributes: [Attribute]

    init(item: Item) {
        self.title = item.title
        self.imageUrl = item.imageUrl
        self.price = item.price.localizedCurrency()
        self.attributes = item.attributes ?? []
    }
}
