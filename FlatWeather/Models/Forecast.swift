//
//  Forecast.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 13..
//

struct Forecast: Codable, Equatable, Hashable {
    let forecastDay: [ForecastDay]
    
    private enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}
