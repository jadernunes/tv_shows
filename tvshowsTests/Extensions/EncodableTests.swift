//
//  EncodableTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class EncodableTests: XCTestCase {

    func testEncodableToJson() {
        let key = "name"
        let name = "a"
        struct Test: Codable {
            let name: String
        }

        let model = Test(name: name)
        let json = model.toJson()
        XCTAssertEqual(json.keys.first, key)

        let value = json[key] as? String
        XCTAssertEqual(value, name)
    }
}
