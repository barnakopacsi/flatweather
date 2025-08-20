//
//  ForecastServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//

protocol ForecastService {
    func grabWeatherData(for location: Search) async throws -> WeatherResponse
    func grabAllLocationWeather(locations: [Search], existingResponses: [FormattedWeatherResponse]) async throws -> [FormattedWeatherResponse]
}
