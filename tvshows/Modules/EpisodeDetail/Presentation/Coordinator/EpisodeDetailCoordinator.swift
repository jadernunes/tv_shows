//
//  EpisodeDetailCoordinator.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 05/04/24.
//

import UIKit

protocol IEpisodeDetailCoordinator {
    func close()
}

final class EpisodeDetailCoordinator: IEpisodeDetailCoordinator {

    // MARK: - Properties

    private weak var presenter: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Methods

    func start(episode: Episode) {
        let viewModel = EpisodeDetailViewModel(episode: episode, coordinator: self)
        let viewController = EpisodeDetailViewController(viewModel: viewModel)
        presenter?.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    func close() {
        presenter?.visibleViewController?.dismiss(animated: true)
    }
}

