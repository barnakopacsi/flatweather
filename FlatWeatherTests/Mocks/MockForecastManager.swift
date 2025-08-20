//
//  MockForecastManager.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import Foundation
@testable import FlatWeather

class MockForecastManager: ForecastService {
    var callCount = 0
    
    func grabWeatherData(for location: Search) async throws -> WeatherResponse {
        callCount += 1
        return WeatherResponse.mock(lat: location.lat, lon: location.lon)
    }
    
    func grabAllLocationWeather(locations: [Search], existingResponses: [FormattedWeatherResponse]) async throws -> [FormattedWeatherResponse] {
        var orderedResults: [FormattedWeatherResponse?] = Array(repeating: nil, count: locations.count)
        let fifteenMinutesAgo = Date().addingTimeInterval(-15 * 60)
        
        return try await withThrowingTaskGroup(of: (Int, FormattedWeatherResponse).self) { group in
            for (index, location) in locations.enumerated() {
                if index < existingResponses.count,
                   existingResponses[index].location.lat == location.lat,
                   existingResponses[index].location.lon == location.lon,
                   existingResponses[index].fetchedAt > fifteenMinutesAgo {
                    orderedResults[index] = existingResponses[index]
                    continue
                }
                
                group.addTask {
                    let forecast = try await self.grabWeatherData(for: location)
                    let formatted = FormattedWeatherResponse(from: forecast, isUserLocation: location.name == "User Location", id: location.id)
                    return (index, formatted)
                }
            }
            
            for try await (index, result) in group {
                orderedResults[index] = result
            }
            
            return orderedResults.compactMap { $0 }
        }
    }
}
