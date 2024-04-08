//
//  HTTPMethodTypeTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class HTTPMethodTypeTests: XCTestCase {
    
    func testEnumHTTPMethodType() {
        let allCases = HTTPMethodType.allCases
        let enumeratedCases: [HTTPMethodType] = [.delete, .get, .patch, .post]

        XCTAssertEqual(HTTPMethodType.allCases.count, 4)
        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .delete)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }
}
