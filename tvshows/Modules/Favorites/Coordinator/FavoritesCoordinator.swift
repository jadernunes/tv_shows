//
//  FavoritesCoordinator.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 08/04/24.
//

import UIKit

protocol IFavoritesCoordinator {
    func presentDetails(show: Show)
}

final class FavoritesCoordinator: IFavoritesCoordinator {

    // MARK: - Properties

    private weak var presenter: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Methods

    func start() {
        let viewModel = FavoritesViewModel(coordinator: self)
        let viewController = FavoritesViewController(viewModel: viewModel)
        presenter?.pushViewController(viewController, animated: true)
    }
    
    func presentDetails(show: Show) {
        guard let navigation = presenter else { return }
        
        let coordinator = ShowDetailCoordinator(presenter: navigation)
        coordinator.start(show: show)
    }
}
