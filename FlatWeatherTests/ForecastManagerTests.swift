//
//  ForecastManagerTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import XCTest
@testable import FlatWeather

final class ForecastManagerTests: XCTestCase {
    func testGrabAllLocationWeather_usesCachedData_whenDataIsFresh() async {
        let locations: [Search] = [Search.mock(id: 1, lat: 15, lon: 15), Search.mock(id: 2, lat: 25, lon: 25)]
        let existingResponses: [FormattedWeatherResponse] = [FormattedWeatherResponse.mock(raw: WeatherResponse.mock(lat: 15, lon: 15), fetchedAt: Date().addingTimeInterval(-5 * 60), id: 1)]
        
        let mockManager = MockForecastManager()
        
        do {
            let forecast = try await mockManager.grabAllLocationWeather(locations: locations, existingResponses: existingResponses)
            
            XCTAssertEqual(mockManager.callCount, 1, "Only the second location should trigger a fetch")
            XCTAssertEqual(forecast.count, 2, "Should return two responses")
            XCTAssertEqual(forecast[0].location.lat, 15, "Location 1 should be the first item in the array.")
            XCTAssertEqual(forecast[1].location.lat, 25, "Location 2 should be the second item in the array.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGrabAllLocationWeather_ignoresCachedData_whenDataIsOld() async {
        let locations: [Search] = [Search.mock(id: 1, lat: 15, lon: 15), Search.mock(id: 2, lat: 25, lon: 25)]
        let existingResponses: [FormattedWeatherResponse] = [FormattedWeatherResponse.mock(raw: WeatherResponse.mock(lat: 15, lon: 15), fetchedAt: Date().addingTimeInterval(-16 * 60), id: 1)]
        
        let mockManager = MockForecastManager()
        
        do {
            let forecast = try await mockManager.grabAllLocationWeather(locations: locations, existingResponses: existingResponses)
            
            XCTAssertEqual(mockManager.callCount, 2, "Both locations should trigger a fetch")
            XCTAssertEqual(forecast.count, 2, "Should return two responses")
            XCTAssertEqual(forecast[0].location.lat, 15, "Location 1 should be the first item in the array.")
            XCTAssertEqual(forecast[1].location.lat, 25, "Location 2 should be the second item in the array.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
