//
//  ViewCode.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setupViewCode() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
