//
//  SearchEndpoints.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation

enum Endpoints {
    case search(query: String)

    var url: URL? {
        var siteId = Constants.brazilianSiteId
        let currentLocale = Locale.current
        let regionCode = currentLocale.identifier
        if regionCode == Constants.argentinaRegionCode {
            siteId = Constants.argentinaSiteId
        }
        switch self {
        case .search(query: let query):
            return URL(string: "https://api.mercadolibre.com/sites/\(siteId)/search?q=\(query)")
        }
    }
}
