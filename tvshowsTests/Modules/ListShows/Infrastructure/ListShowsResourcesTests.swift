//
//  ListShowsResourcesTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation

import XCTest
@testable import tvshows

final class ListShowsResourcesTests: XCTestCase {
    
    func testListAllShows() {
        let resources = ListShowsResources.loadAll(page: 1)
        XCTAssertEqual(resources.method, .get)
        XCTAssertEqual(resources.path, "/shows")
        
        XCTAssertEqual(resources.parameters?["page"] as? Int, 1)
    }

    func testSearchShows() {
        let resources = ListShowsResources.search(text: "a")
        XCTAssertEqual(resources.method, .get)
        XCTAssertEqual(resources.path, "/search/shows")
        
        XCTAssertEqual(resources.parameters?["q"] as? String, "a")
    }
}
