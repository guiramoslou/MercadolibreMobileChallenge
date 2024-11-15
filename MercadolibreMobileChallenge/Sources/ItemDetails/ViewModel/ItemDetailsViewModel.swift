//
//  ItemDetailsViewModel.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

protocol ItemDetailsViewModelProtocol {
    var image: URL { get }
    var title: String { get }
    var attributes: [Attribute] { get }
}

class ItemDetailsViewModel: ItemDetailsViewModelProtocol {
    let image: URL
    let title: String
    let attributes: [Attribute]
    
    init(item: Item) {
        self.image = item.thumbnail
        self.title = item.title
        self.attributes = item.attributes ?? []
    }
}
