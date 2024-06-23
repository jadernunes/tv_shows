//
//  NetworkErrorTypeTests.swift
//  
//
//  Created by Jader Nunes on 23/06/24.
//

import XCTest
@testable import NetworkSession

final class NetworkErrorTypeTests: XCTestCase {
    
    func testErrorTypeRequest() {
        let error: NetworkErrorType = .noInternet
        XCTAssertEqual(error.message, "No internet")
    }
}
