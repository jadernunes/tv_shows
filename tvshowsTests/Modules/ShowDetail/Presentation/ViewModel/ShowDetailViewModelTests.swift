//
//  ShowDetailViewModelTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ShowDetailViewModelTests: XCTestCase {
    
    func testLoadDataSuccess() async throws {
        guard let url = URL(string: "http://www.google.com") else { return }
        
        let showDTO = ShowDTO(
            id: 1,
            name: "a",
            language: "b",
            image: ShowImageDTO(
                medium: url,
                original: url),
            summary: "c",
            schedule: ScheduleDTO(
                time: "1:00",
                days: ["Monday"]),
            genres: ["Male"],
            isFavorite: false)
        
        let episodeDTO = EpisodeDTO(
            id: 1,
            name: "a",
            season: 1,
            number: 1,
            summary: "b",
            image: ShowImageDTO(
                medium: url,
                original: url))
        
        let network = NetworkMock(data: [episodeDTO])
        let service = ShowDetailService(network: network)
        let viewModel = ShowDetailViewModel(show: showDTO.asShow, service: service)
        
        XCTAssertEqual(viewModel.state, .idle)
        await viewModel.loadData()
        
        switch viewModel.state {
        case let .ready(show, seasons):
            XCTAssertEqual(show.id, 1)
            XCTAssertEqual(show.name, "a")
            XCTAssertEqual(show.language, "b")
            XCTAssertEqual(show.image?.original, url)
            XCTAssertEqual(show.image?.medium, url)
            XCTAssertEqual(show.summary, "c")
            XCTAssertEqual(show.schedule?.time, "1:00")
            XCTAssertEqual(show.schedule?.days, ["Monday"])
            XCTAssertEqual(show.genres, ["Male"])
            
            XCTAssertEqual(seasons.first, Season(id: 1, episodes: [episodeDTO.asEpisode]))
            XCTAssertEqual(seasons.count, 1)
        default:
            XCTFail()
        }
    }
}
