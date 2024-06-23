//
//  NetworkErrorTypeTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
import NetworkSession
@testable import tvshows

final class NetworkErrorTypeTests: XCTestCase {
    
    func testErrorTypeRequest() {
        let error: NetworkErrorType = .noInternet
        XCTAssertEqual(error.message, "No internet")
    }
}
