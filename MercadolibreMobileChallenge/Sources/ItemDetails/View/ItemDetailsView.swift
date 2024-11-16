//
//  ItemDetailsView.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

class ItemDetailsView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(title)
        contentView.addSubview(image)
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
            
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 128),
            image.heightAnchor.constraint(equalToConstant: 128),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            attributes.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            attributes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attributes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            attributes.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    func setupStyle() {
        backgroundColor = .systemIndigo
    }
}
