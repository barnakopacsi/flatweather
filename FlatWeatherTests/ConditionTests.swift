//
//  ConditionTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import Foundation
import XCTest
@testable import FlatWeather

final class ConditionTests: XCTestCase {
    func testConditionCode_returnsCorrectSfSymbolName() {
        let cases: [(code: Int, isDay: Int, expected: String)] = [
            (1000, 1, "sun.max"),
            (1000, 0, "moon.stars"),
            (1003, 1, "cloud.sun"),
            (1003, 0, "cloud.moon"),
            (1006, 1, "cloud"),
            (1030, 0, "cloud.fog"),
            (1183, 1, "cloud.rain"),
            (1195, 0, "cloud.heavyrain"),
            (1210, 1, "cloud.snow"),
            (1087, 0, "cloud.bolt.rain"),
            (1279, 1, "cloud.bolt.snow"),
            (9999, 1, "cloud")
        ]
        
        for testCase in cases {
            let condition = Condition(code: testCase.code)
            XCTAssertEqual(condition.sfSymbol(isDay: testCase.isDay), testCase.expected, "Failed for code \(testCase.code), isDay: \(testCase.isDay)")
        }
    }
}
