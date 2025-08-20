//
//  CurrentTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import XCTest
@testable import FlatWeather

final class CurrentTests: XCTestCase {
    func testFeelsLike_returnsCorrectString() {
        let current = WeatherResponse.mock().current
        
        let celsiusResult = current.feelsLike(tempSetting: .celsius)
        XCTAssertEqual(celsiusResult, "\(Int(current.feelsLikeC.rounded()))°", "Feels like temperature should be \(Int(current.feelsLikeC.rounded()))° when the tempSetting is celsius")
        
        let fahrenheitResult = current.feelsLike(tempSetting: .fahrenheit)
        XCTAssertEqual(fahrenheitResult, "\(Int(current.feelsLikeF.rounded()))°", "Feels like temperature should be \(Int(current.feelsLikeF.rounded()))° when the tempSetting is fahrenheit")
    }
    
    func testGust_returnsCorrectString() {
        let current = WeatherResponse.mock().current
        
        let metricResult = current.gust(measurementSetting: .metric)
        XCTAssertEqual(metricResult, "\(Int(current.gustKph.rounded())) km/h", "Gust should be \(Int(current.gustKph.rounded())) km/h when the measurementSetting is metric")
        
        let imperialResult = current.gust(measurementSetting: .imperial)
        XCTAssertEqual(imperialResult, "\(Int(current.gustMph.rounded())) mph", "Gust should be \(Int(current.gustMph.rounded())) mph when the measurementSetting is imperial")
    }
    
    func testHumidityInfo_returnsCorrectTuple() {
        let testCases: [(humidity: Int, expectedLevel: String, expectedDescription: String)] = [
            (10, "Low", "The air may feel dry."),
            (60, "Optimal", "The air should feel comfortable."),
            (70, "High", "The air may feel muggy."),
            (85, "Very high", "The air may feel uncomfortable.")
        ]
        
        for testCase in testCases {
            let current = Current(
                condition: Condition(code: 1000),
                feelsLikeC: 0, feelsLikeF: 0,
                gustKph: 0, gustMph: 0,
                humidity: testCase.humidity,
                isDay: 1,
                precipIn: 0, precipMm: 0,
                tempC: 0, tempF: 0,
                uv: 0, visKm: 0, visMiles: 0,
                windDegree: 0, windDir: "",
                windKph: 0, windMph: 0
            )
            
            let info = current.humidityInfo
            XCTAssertEqual(info.value, testCase.humidity, "Humdity should be \(testCase.humidity)%")
            XCTAssertEqual(info.level, testCase.expectedLevel, "Humidity level should be \(testCase.expectedLevel)")
            XCTAssertEqual(info.description, testCase.expectedDescription, "Humidity description should be \(testCase.expectedDescription)")
        }
    }
    
    func testTemperature_returnsCorrectString() {
        let current = WeatherResponse.mock().current
        
        let celsiusResult = current.temperature(tempSetting: .celsius)
        XCTAssertEqual(celsiusResult, "\(Int(current.tempC.rounded()))°", "Feels like temperature should be \(Int(current.tempC.rounded()))° when the tempSetting is celsius")
        
        let fahrenheitResult = current.temperature(tempSetting: .fahrenheit)
        XCTAssertEqual(fahrenheitResult, "\(Int(current.tempF.rounded()))°", "Feels like temperature should be \(Int(current.tempF.rounded()))° when the tempSetting is fahrenheit")
    }
    
    func testUvInfo_returnsCorrectTuple() {
        let testCases: [(uv: Double, uvIndex: Int, expectedDescription: String)] = [
            (2, Int(2), "Low"),
            (5, Int(5), "Moderate"),
            (7, Int(7), "High"),
            (10, Int(10), "Very High"),
            (11, Int(11), "Extreme")
        ]
        
        for testCase in testCases {
            let current = Current(
                condition: Condition(code: 1000),
                feelsLikeC: 0, feelsLikeF: 0,
                gustKph: 0, gustMph: 0,
                humidity: 0,
                isDay: 1,
                precipIn: 0, precipMm: 0,
                tempC: 0, tempF: 0,
                uv: testCase.uv, visKm: 0, visMiles: 0,
                windDegree: 0, windDir: "",
                windKph: 0, windMph: 0
            )
            
            let info = current.uvInfo
            XCTAssertEqual(info.uvIndex, testCase.uvIndex, "UV Index should be \(testCase.uvIndex)")
            XCTAssertEqual(info.uvDescription, testCase.expectedDescription, "UV description should be \(testCase.expectedDescription)")
        }
    }
    
    func testVisibilityInfo_withMetricSettings_returnsCorrectTuple() {
        let testCases: [(raw: Double, value: String, expectedLevel: String, expectedDescription: String)] = [
            (0.5, "1 km", "Very low", "It may be hard to see far ahead."),
            (2.0, "2 km", "Limited", "Outdoor conditions may feel hazy."),
            (5.0, "5 km", "Fair", "You should be able to see a good distance."),
            (15.0, "15 km", "Good", "Most things are clearly visible."),
            (25.0, "25 km", "Excellent", "The air is very clear.")
        ]
        
        for testCase in testCases {
            let current = Current(
                condition: Condition(code: 1000),
                feelsLikeC: 0, feelsLikeF: 0,
                gustKph: 0, gustMph: 0,
                humidity: 0,
                isDay: 1,
                precipIn: 0, precipMm: 0,
                tempC: 0, tempF: 0,
                uv: 0, visKm: testCase.raw, visMiles: 0,
                windDegree: 0, windDir: "",
                windKph: 0, windMph: 0
            )
            
            let info = current.visibilityInfo(measurementSetting: .metric)
            XCTAssertEqual(info.value, testCase.value, "Visibility value should be \(testCase.value)")
            XCTAssertEqual(info.level, testCase.expectedLevel, "Visibility level should be \(testCase.expectedLevel)")
            XCTAssertEqual(info.description, testCase.expectedDescription, "Visibility description should be \(testCase.expectedDescription)")
        }
    }
    
    func testVisibilityInfo_withImperialSettings_returnsCorrectTuple() {
        let testCases: [(raw: Double, value: String, expectedLevel: String, expectedDescription: String)] = [
                    (0.5, "1 mi", "Very low", "It may be hard to see far ahead."),
                    (2.1, "2 mi", "Limited", "Outdoor conditions may feel hazy."),
                    (6.1, "6 mi", "Fair", "You should be able to see a good distance."),
                    (12.3, "12 mi", "Good", "Most things are clearly visible."),
                    (12.6, "13 mi", "Excellent", "The air is very clear.")
                ]
                
                for testCase in testCases {
                    let current = Current(
                        condition: Condition(code: 1000),
                        feelsLikeC: 0, feelsLikeF: 0,
                        gustKph: 0, gustMph: 0,
                        humidity: 0,
                        isDay: 1,
                        precipIn: 0, precipMm: 0,
                        tempC: 0, tempF: 0,
                        uv: 0, visKm: 0, visMiles: testCase.raw,
                        windDegree: 0, windDir: "",
                        windKph: 0, windMph: 0
                    )
                    
                    let info = current.visibilityInfo(measurementSetting: .imperial)
                    XCTAssertEqual(info.value, testCase.value, "Visibility value should be \(testCase.value)")
                    XCTAssertEqual(info.level, testCase.expectedLevel, "Visibility level should be \(testCase.expectedLevel)")
                    XCTAssertEqual(info.description, testCase.expectedDescription, "Visibility description should be \(testCase.expectedDescription)")
                }
    }
    
    func testWindInfo_withMetricSetting_returnsCorrectTuple() {
        let current = WeatherResponse.mock().current

        let info = current.windInfo(measurementSetting: .metric)
        XCTAssertEqual(info.value, "\(Int(current.windKph.rounded())) km/h", "Wind value should be \(Int(current.windKph.rounded())) km/h")
        XCTAssertEqual(info.degree, current.windDegree, "Wind degree should be \(current.windDegree)")
        XCTAssertEqual(info.direction, current.windDir, "Wind direction should be \(current.windDir)")
        XCTAssertEqual(info.gust, "\(Int(current.gustKph.rounded())) km/h", "Gust value should be \(Int(current.gustKph.rounded())) km/h")
    }
    
    func testWindInfo_withImperialSetting_returnsCorrectTuple() {
        let current = WeatherResponse.mock().current

        let info = current.windInfo(measurementSetting: .imperial)
        XCTAssertEqual(info.value, "\(Int(current.windMph.rounded())) mph", "Wind value should be \(Int(current.windMph.rounded())) mph")
        XCTAssertEqual(info.degree, current.windDegree, "Wind degree should be \(current.windDegree)")
        XCTAssertEqual(info.direction, current.windDir, "Wind direction should be \(current.windDir)")
        XCTAssertEqual(info.gust, "\(Int(current.gustMph.rounded())) mph", "Gust value should be \(Int(current.gustMph.rounded())) mph")
    }
}
