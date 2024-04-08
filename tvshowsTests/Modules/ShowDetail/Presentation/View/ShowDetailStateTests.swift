//
//  ShowDetailStateTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ShowDetailStateTests: XCTestCase {
    
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
        
        let episode = Episode(
            id: 1,
            name: "a",
            season: 1,
            number: 1,
            summary: "b",
            image: ShowImage(
                medium: url,
                original: url))
        
        let state1: ShowDetailState = .ready(show: show, seasons: [Season(id: 1, episodes: [episode])])
        let state2: ShowDetailState = .ready(show: show, seasons: [Season(id: 1, episodes: [episode])])
        let state3: ShowDetailState = .loading
        let state4: ShowDetailState = .empty
        
        XCTAssertEqual(state1, state2)
        XCTAssertNotEqual(state1, state3)
        XCTAssertNotEqual(state1, state4)
        XCTAssertNotEqual(state3, state4)
    }
}
