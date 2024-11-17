//
//  ItemDetailsViewViewController.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class ItemDetailsViewController: UIViewController {
    private let itemDetailsView = ItemDetailsView(frame: UIScreen.main.bounds)
    private let viewModel: ItemDetailsViewModelProtocol

    override func loadView() {
        super.loadView()
        view = itemDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailsView.setupContent(title: viewModel.title, imageUrl: viewModel.imageUrl, price: viewModel.price, attributes: viewModel.attributes)
    }

    init(viewModel: ItemDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
