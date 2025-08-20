//
//  ForecastManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//
//  Fetches weather data from WeatherAPI for single or multiple locations.
//

import Foundation

struct ForecastManager: ForecastService {
    private let apiKey = Config.weatherAPIKey
    
    func grabWeatherData(for location: Search) async throws -> WeatherResponse {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(location.lat),\(location.lon)&days=3&aqi=no&alerts=no"
        guard let url = URL(string: urlString) else {
            throw ForecastManagerError.invalidURL
        }
        
        let forecast = try await URLSession.shared.decode(WeatherResponse.self, from: url)
        return forecast
    }
    
    /// Fetches weather data for multiple locations concurrently.
    /// Uses cached data if it is less than 15 minutes old.
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

enum ForecastManagerError: Error {
    case invalidURL
    
    var userFriendlyMessage: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("One of the locations could not be found. Please try again later.", comment: "")
        }
    }
}
