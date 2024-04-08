//
//  InitialFlowTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class InitialFlowTests: XCTestCase {
    
    func testEnumInitialFlow() {
        let allCases = InitialFlow.allCases
        let enumeratedCases: [InitialFlow] = [.listShows]

        XCTAssertEqual(InitialFlow.allCases.count, 1)
        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .listShows)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }
}
