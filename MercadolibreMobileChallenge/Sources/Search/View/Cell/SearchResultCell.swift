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
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(imageUrl: URL?, title: String, price: String) {
        self.image.load(url: imageUrl)
        self.title.text = title
        self.price.text = price
        selectionStyle = .none
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
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: image.topAnchor),

            price.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
