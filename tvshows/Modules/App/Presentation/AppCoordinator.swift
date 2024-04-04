//
//  AppCoordinator.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import UIKit

final class AppCoordinator {

    // MARK: - Properties

    private let window: UIWindow?
    private let initialFlow: InitialFlow

    // MARK: - Life cycle

    init(window: UIWindow?, initialFlow: InitialFlow = .listShows) {
        self.window = window
        self.initialFlow = initialFlow
    }

    // MARK: - Methods

    func start() {
        switch initialFlow {
        case .listShows:
            openListShows()
        }
    }

    // MARK: - Navigations

    private func openListShows() {
        let navigation = UINavigationController()
        let coodinator = ListShowsCoordinator(presenter: navigation)
        coodinator.start()

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
