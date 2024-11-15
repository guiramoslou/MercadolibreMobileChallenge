//
//  ItemDetailsView.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

class ItemDetailsView: UIView {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemRed
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var attributes: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(imageUrl: URL, title: String, attributes: [Attribute]) {
        self.image.load(url: imageUrl)
        self.title.text = title
        for attribute in attributes {
            guard let name = attribute.name,
                  let value = attribute.value_name else { continue }
            let label = UILabel()
            label.text = "\(name): \(value)"
            self.attributes.addArrangedSubview(label)
        }
    }
}

extension ItemDetailsView: ViewCode {
    func addSubviews() {
        addSubview(title)
        addSubview(image)
        addSubview(attributes)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 128),
            image.heightAnchor.constraint(equalToConstant: 128),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            attributes.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            attributes.leadingAnchor.constraint(equalTo: leadingAnchor),
            attributes.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setupStyle() {
        backgroundColor = .systemIndigo
    }
}
