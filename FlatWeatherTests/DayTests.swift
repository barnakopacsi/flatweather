//
//  DayTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import XCTest
@testable import FlatWeather

final class DayTests: XCTestCase {
    func testMaxTemperature_returnsCorrectString() {
        let day = WeatherResponse.mock().forecast.forecastDay.first!.day
        
        let celsiusResult = day.maxTemperature(tempSetting: .celsius)
        XCTAssertEqual(celsiusResult, "\(Int(day.maxTempC.rounded()))°", "Max temperature should be \(Int(day.maxTempC.rounded()))° when tempSetting is celsius")
        
        let fahrenheitResult = day.maxTemperature(tempSetting: .fahrenheit)
        XCTAssertEqual(fahrenheitResult, "\(Int(day.maxTempF.rounded()))°", "Max temperature should be \(Int(day.maxTempF.rounded()))° when tempSetting is fahrenheit")
    }
    
    func testMinTemperature_returnsCorrectString() {
        let day = WeatherResponse.mock().forecast.forecastDay.first!.day
        
        let celsiusResult = day.minTemperature(tempSetting: .celsius)
        XCTAssertEqual(celsiusResult, "\(Int(day.minTempC.rounded()))°", "Min temperature should be \(Int(day.minTempC.rounded()))° when tempSetting is celsius")
        
        let fahrenheitResult = day.minTemperature(tempSetting: .fahrenheit)
        XCTAssertEqual(fahrenheitResult, "\(Int(day.minTempF.rounded()))°", "Min temperature should be \(Int(day.minTempF.rounded()))° when tempSetting is fahrenheit")
    }
    
    func testTotalPrecipation_returnsCorrectString() {
        let day = WeatherResponse.mock().forecast.forecastDay.first!.day
        
        let metricResult = day.totalPrecipation(measurementSetting: .metric)
        XCTAssertEqual(metricResult, "\(Int(day.totalPrecipMm.rounded())) mm", "Total precipitation should be \(Int(day.totalPrecipMm.rounded())) mm when measurementSetting is metric")
        
        let imperialResult = day.totalPrecipation(measurementSetting: .imperial)
        XCTAssertEqual(imperialResult, "\(Int(day.totalPrecipIn.rounded())) in", "Total precipitation should be \(Int(day.totalPrecipIn.rounded())) in when measurementSetting is imperial")
    }
}
