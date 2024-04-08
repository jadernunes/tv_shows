//
//  ShowDetailServiceTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ShowDetailServiceTests: XCTestCase {
    
    func testLoadAllSuccess() async throws {
        guard let url = URL(string: "http://www.google.com") else { return }
        
        let dto = EpisodeDTO(
            id: 1,
            name: "a",
            season: 1,
            number: 1,
            summary: "b",
            image: ShowImageDTO(
                medium: url,
                original: url))
        
        
        let network = NetworkMock(data: [dto])
        let service = ShowDetailService(network: network)
        let episodes = try await service.loadEpisodes(showID: 1)
        
        XCTAssertEqual(episodes.count, 1)
        
        let firstEpisode = episodes.first?.asEpisode
        XCTAssertEqual(firstEpisode?.id, 1)
        XCTAssertEqual(firstEpisode?.name, "a")
        XCTAssertEqual(firstEpisode?.season, 1)
        XCTAssertEqual(firstEpisode?.number, 1)
        XCTAssertEqual(firstEpisode?.summary, "b")
        XCTAssertEqual(firstEpisode?.image?.original, url)
        XCTAssertEqual(firstEpisode?.image?.medium, url)
    }
}
