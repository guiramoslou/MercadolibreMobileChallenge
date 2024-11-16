//
//  ItemDetailsViewViewController.swift
//  MercadolibreMobileChallenge
//
//  Created by Guilherme Lourenco on 15/11/24.
//

import UIKit

final class ItemDetailsViewViewController: UIViewController {
    private let itemDetailsView = ItemDetailsView(frame: UIScreen.main.bounds)
    private let viewModel: ItemDetailsViewModelProtocol

    override func loadView() {
        super.loadView()
        view = itemDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailsView.setupContent(imageUrl: viewModel.image, title: viewModel.title, attributes: viewModel.attributes)
    }

    init(viewModel: ItemDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
