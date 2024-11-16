//
//  ItemDetailsView.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class ItemDetailsView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var attributes: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContent(title: String, imageUrl: URL?, price: String, attributes: [Attribute]) {
        self.title.text = title
        self.image.load(url: imageUrl)
        self.price.text = price
        for attribute in attributes {
            guard let name = attribute.keyName,
                  let value = attribute.valueName else { continue }
            let label = setupAttributeLabel(name, value)
            self.attributes.addArrangedSubview(label)
        }
    }

    private func setupAttributeLabel(_ name: String, _ value: String) -> UILabel {
        let label = UILabel()
        label.text = "\(name): \(value)"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }
}

extension ItemDetailsView: ViewCode {
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(title)
        contentView.addSubview(image)
        contentView.addSubview(price)
        contentView.addSubview(attributes)
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 128),
            image.heightAnchor.constraint(equalToConstant: 128),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            price.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            attributes.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 8),
            attributes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            attributes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            attributes.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
