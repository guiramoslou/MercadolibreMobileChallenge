//
//  ItemDetailsViewViewController.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class ItemDetailsViewController: UIViewController {
    private let itemDetailsView: ItemDetailsViewProtocol
    private let viewModel: ItemDetailsViewModelProtocol

    override func loadView() {
        super.loadView()
        view = itemDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailsView.setupContent(title: viewModel.title, imageUrl: viewModel.imageUrl, price: viewModel.price, attributes: viewModel.attributes)
    }

    init(viewModel: ItemDetailsViewModelProtocol, view: ItemDetailsViewProtocol = ItemDetailsView(frame: UIScreen.main.bounds)) {
        self.viewModel = viewModel
        self.itemDetailsView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
