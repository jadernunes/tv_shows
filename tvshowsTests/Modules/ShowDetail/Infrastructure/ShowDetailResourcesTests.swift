//
//  ShowDetailResourcesTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation

import XCTest
@testable import tvshows

final class ShowDetailResourcesTests: XCTestCase {
    
    func testListAllEpisodes() {
        let resources = ShowDetailResources.loadEpisodes(showID: 1)
        XCTAssertEqual(resources.method, .get)
        XCTAssertEqual(resources.path, "/shows/1/episodes")
    }
}
