//
//  SearchResult.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

struct SearchResult: Decodable {
    let query: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case query
        case items = "results"
    }
}

struct Item: Decodable {
    let title: String
    let imageUrl: URL?
    let price: Double
    let attributes: [Attribute]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "thumbnail"
        case price
        case attributes
    }
}

struct Attribute: Decodable {
    let keyName: String?
    let valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case keyName = "name"
        case valueName = "value_name"
    }
}
