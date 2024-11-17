//
//  BinaryFloatingPoint+Extension.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 17/11/24.
//

import Foundation

extension BinaryFloatingPoint {
    func localizedCurrency() -> String {
        var currencyCode = Constants.brazilianCurrencyCode
        let currentLocale = Locale.current
        let regionCode = currentLocale.identifier
        if regionCode == Constants.argentinaRegionCode {
            currencyCode = Constants.argentinanCurrencyCode
        }
        return self.formatted(.currency(code: currencyCode))
    }
}
