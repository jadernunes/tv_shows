//
//  JSONDecoderTests.swift
//  tvshowsTests
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import XCTest
@testable import tvshows

final class JSONDecoderTests: XCTestCase {
    
    func testDecoderStrategy() {
        guard let jsonData = """
            {
                "time": "10:00",
                "days": ["Monday", "Tuesday"]
            }
            """.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let decodedObject = try? JSONDecoder.decoder.decode(ScheduleDTO.self, from: jsonData)
        
        XCTAssertNotNil(decodedObject)
        XCTAssertEqual(decodedObject?.asSchedule.time, "10:00")
        XCTAssertEqual(decodedObject?.asSchedule.days.count, 2)
        XCTAssertEqual(decodedObject?.asSchedule.days.first, "Monday")
    }
}
