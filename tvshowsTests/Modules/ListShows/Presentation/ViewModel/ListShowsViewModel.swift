//
//  ListShowsViewModel.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ListShowsViewModelTests: XCTestCase {
    
    func testLoadDataSuccess() async throws {
        guard let url = URL(string: "http://www.google.com") else { return }
        
        let dto = ShowDTO(
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
            genres: ["Male"])
        
        let network = NetworkMock(data: [dto])
        let service = ListShowsService(network: network)
        let viewModel = ListShowsViewModel(service: service)
        
        XCTAssertEqual(viewModel.state, .idle)
        await viewModel.loadData(currentShow: nil)
        
        switch viewModel.state {
        case let .ready(shows):
            XCTAssertEqual(shows.count, 1)
            let firstShow = shows.first
            
            XCTAssertEqual(firstShow?.id, 1)
            XCTAssertEqual(firstShow?.name, "a")
            XCTAssertEqual(firstShow?.language, "b")
            XCTAssertEqual(firstShow?.image?.original, url)
            XCTAssertEqual(firstShow?.image?.medium, url)
            XCTAssertEqual(firstShow?.summary, "c")
            XCTAssertEqual(firstShow?.schedule?.time, "1:00")
            XCTAssertEqual(firstShow?.schedule?.days, ["Monday"])
            XCTAssertEqual(firstShow?.genres, ["Male"])
            
            if let firstShow {
                XCTAssertTrue(viewModel.shouldShowLoadMore(currentShow: firstShow))
            }
        default:
            XCTFail()
        }
    }
}
