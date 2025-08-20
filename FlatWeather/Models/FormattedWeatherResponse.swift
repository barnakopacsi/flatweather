//
//  FormattedWeatherResponse.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 31..
//

import Foundation

struct FormattedWeatherResponse: Identifiable, Equatable {
    let location: Location
    let current: Current
    let forecastDays: [ForecastDay]
    let hourlyItemIndexPaths: [HourIndexPath]
    
    let fetchedAt: Date
    let isUserLocation: Bool
    let id: Int
    
    init(from raw: WeatherResponse, fetchedAt: Date = Date(), isUserLocation: Bool = false, id: Int) {
        self.location = raw.location
        self.current = raw.current
        self.forecastDays = raw.forecast.forecastDay
        self.hourlyItemIndexPaths = raw.computeHourlyItemIndexPaths(from: raw.forecast.forecastDay, currentEpoch: raw.location.localTimeEpoch)
        self.fetchedAt = fetchedAt
        self.isUserLocation = isUserLocation
        self.id = id
    }
}
