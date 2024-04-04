//
//  ListShowsCoordinator.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import UIKit

protocol IListShowsCoordinator {}

final class ListShowsCoordinator: IListShowsCoordinator {

    // MARK: - Properties

    private weak var presenter: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Methods

    func start() {
        let viewModel = ListShowsViewModel(coordinator: self)
        let viewController = ListShowsViewController(viewModel: viewModel)
        presenter?.viewControllers = [viewController]
    }
}
