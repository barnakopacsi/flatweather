//
//  HourTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import XCTest
@testable import FlatWeather

final class HourTests: XCTestCase {
    func testTemperature_returnsCorrectString() {
        let hour = WeatherResponse.mock().forecast.forecastDay.first!.hour.first!
        
        let celsiusResult = hour.temperature(tempSetting: .celsius)
        XCTAssertEqual(celsiusResult, "\(Int(hour.tempC.rounded()))°", "Temperature should be \(Int(hour.tempC.rounded()))° when tempSetting is celsius")
        
        let fahrenheitResult = hour.temperature(tempSetting: .fahrenheit)
        XCTAssertEqual(fahrenheitResult, "\(Int(hour.tempF.rounded()))°", "Temperature should be \(Int(hour.tempF.rounded()))° when tempSetting is fahrenheit")
    }
}
