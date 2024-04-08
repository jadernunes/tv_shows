//
//  ListShowsStateTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ListShowsStateTests: XCTestCase {
    
    func testAllStates() {
        guard let url = URL(string: "http://www.google.com") else { return }
        
        let show = Show(
            id: 1,
            name: "a",
            language: "b",
            image: ShowImage(
                medium: url,
                original: url),
            summary: "c",
            schedule: Schedule(
                time: "1:00",
                days: ["Monday"]),
            genres: ["Male"])
        
        let state1: ListShowsState = .ready(shows: [show])
        let state2: ListShowsState = .ready(shows: [show])
        let state3: ListShowsState = .loading
        let state4: ListShowsState = .empty
        
        XCTAssertEqual(state1, state2)
        XCTAssertNotEqual(state1, state3)
        XCTAssertNotEqual(state1, state4)
        XCTAssertNotEqual(state3, state4)
    }
}
