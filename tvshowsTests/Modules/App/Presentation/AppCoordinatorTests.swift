//
//  AppCoordinatorTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class AppCoordinatorTests: XCTestCase {
    
    func testAppCoordinatorDefaultFlow() {
        let window = UIWindow()
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        
        let navigation = window.rootViewController as? UINavigationController
        
        XCTAssertTrue(navigation?.topViewController is ListShowsViewController<ListShowsViewModel>)
    }
}
