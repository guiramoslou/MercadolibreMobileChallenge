//
//  SearchViewCellCollectionViewCell.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

class SearchResultCell: UITableViewCell {
    static let reuseIdentifier = "SearchResultCell"

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemRed
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        return image
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(imageUrl: URL, title: String, price: String) {
        self.image.load(url: imageUrl)
        self.title.text = title
        self.price.text = price
    }
}

extension SearchResultCell: ViewCode {
    func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(price)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 64),
            image.heightAnchor.constraint(equalToConstant: 64),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func setupStyle() {
        backgroundColor = .systemCyan
    }
}