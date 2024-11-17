//
//  Localize.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation

enum Localize: String {
    case searchForProducts
    case genericError
    case noResultError
    case transportError
    case serverError
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: String())
    }
}
