//
//  ShowDetailCoordinator.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import UIKit

protocol IShowDetailCoordinator {}

final class ShowDetailCoordinator: IShowDetailCoordinator {

    // MARK: - Properties

    private weak var presenter: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Methods

    func start(show: Show) {
        let viewModel = ShowDetailViewModel(show: show, coordinator: self)
        let viewController = ShowDetailViewController(viewModel: viewModel)
        presenter?.pushViewController(viewController, animated: true)
    }
}
