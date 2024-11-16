//
//  SearchResult.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import Foundation

struct SearchResult: Decodable {
    let site_id: String
    let country_default_time_zone: String
    let query: String
    let results: [Item]
}

struct Item: Decodable {
    let title: String
    let thumbnail: URL?
    let price: Double
    let attributes: [Attribute]?
}

struct Attribute: Decodable {
    let name: String?
    let value_name: String?
}
