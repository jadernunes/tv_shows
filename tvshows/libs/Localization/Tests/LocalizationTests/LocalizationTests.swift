//
//  LocalizationTests.swift
//
//
//  Created by Jader Nunes on 22/06/24.
//

import XCTest
@testable import Localization

final class LocalizationTests: XCTestCase {
    func testExample() throws {
        enum EnumString: String, LocalizableString {
            case test = "test"
        }
        
        XCTAssertEqual(EnumString.test.localized(bundle: .module), "Test1")
    }
}
