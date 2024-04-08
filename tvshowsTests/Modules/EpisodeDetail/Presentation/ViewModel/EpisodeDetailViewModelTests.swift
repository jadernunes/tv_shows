//
//  EpisodeDetailViewModelTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Combine
import XCTest
@testable import tvshows

final class EpisodeDetailViewModelTests: XCTestCase {
    
    private var cancelables = Set<AnyCancellable>()
    
    func testHasEpisode() async throws {
        guard let url = URL(string: "http://www.google.com") else { return }
        
        let episodeDTO = EpisodeDTO(
            id: 1,
            name: "a",
            season: 1,
            number: 1,
            summary: "b",
            image: ShowImageDTO(
                medium: url,
                original: url))
        
        let viewModel = EpisodeDetailViewModel(episode: episodeDTO.asEpisode)
        
        viewModel.$episode
            .receive(on: DispatchQueue.main)
            .sink { episode in
                XCTAssertEqual(episode.id, 1)
                XCTAssertEqual(episode.name, "a")
                XCTAssertEqual(episode.season, 1)
                XCTAssertEqual(episode.number, 1)
                XCTAssertEqual(episode.summary, "b")
                XCTAssertEqual(episode.image?.original, url)
                XCTAssertEqual(episode.image?.medium, url)
            }.store(in: &cancelables)
    }
}
