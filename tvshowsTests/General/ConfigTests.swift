//
//  ConfigTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class ConfigTests: XCTestCase {
    
    func testCongigKeysExist() {
        XCTAssertFalse(Config.baseURL.isEmpty)
    }
}
