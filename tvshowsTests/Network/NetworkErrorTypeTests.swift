//
//  NetworkErrorTypeTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class NetworkErrorTypeTests: XCTestCase {
    
    func testErrorTypeRequest() {
        let error: NetworkErrorType = .noInternet(message: "aaa")
        
        switch error {
        case let .noInternet(message):
            XCTAssertEqual(message, "aaa")
        default:
            XCTFail()
        }
    }
}
