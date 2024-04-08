//
//  DateFormatterTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class DateFormatterTests: XCTestCase {
    
    func testDateFormatReceived() {
        XCTAssertEqual(DateFormatter.dateFormatterReveiced.dateFormat, DateFormatType.serverShort.rawValue)
    }
    
    func testDateTypeExpected() {
        XCTAssertEqual(DateFormatType.serverLong.rawValue, "yyyy-MM-dd hh:mm:ss")
        XCTAssertEqual(DateFormatType.serverShort.rawValue, "yyyy-MM-dd")
    }
}
