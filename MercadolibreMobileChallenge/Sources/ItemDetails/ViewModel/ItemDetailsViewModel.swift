//
//  ItemDetailsViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol ItemDetailsViewModelProtocol {
    var title: String { get }
    var image: URL? { get }
    var price: String { get }
    var attributes: [Attribute] { get }
}

final class ItemDetailsViewModel: ItemDetailsViewModelProtocol {
    let title: String
    let image: URL?
    let price: String
    let attributes: [Attribute]

    init(item: Item) {
        self.title = item.title
        self.image = item.thumbnail
        self.price = item.price.formatted(.currency(code: "BRL"))
        self.attributes = item.attributes ?? []
    }
}
