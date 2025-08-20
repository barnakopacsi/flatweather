//
//  WeatherResponseTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import Foundation
import XCTest
@testable import FlatWeather

final class WeatherResponseTests: XCTestCase {
    func testComputeHourlyItemIndexPaths_returnsCorrect25Indices() {
        let weatherResponse = WeatherResponse.mock()
        let forecastDays = weatherResponse.forecast.forecastDay
        let currentEpoch = 1_755_126_000 + 6 * 3600 // 6th hour of the first forecast day

        let indices = weatherResponse.computeHourlyItemIndexPaths(from: forecastDays, currentEpoch: currentEpoch)

        XCTAssertEqual(indices.count, 25, "There should be exactly 25 indices")
        XCTAssertEqual(indices.first, HourIndexPath(dayIndex: 0, hourIndex: 6), "The first indice should be for the 6th hour of the first day")
        XCTAssertEqual(indices.last, HourIndexPath(dayIndex: 1, hourIndex: 6), "The last indice should be for the 6th hour of the second day")
    }
}
