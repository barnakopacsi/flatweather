//
//  WeatherResponse.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

import Foundation

struct WeatherResponse: Codable, Hashable, Equatable {
    let current: Current
    let forecast: Forecast
    let location: Location
    
    private enum CodingKeys: String, CodingKey {
        case current, forecast, location
    }
}

extension WeatherResponse {
    func computeHourlyItemIndexPaths(from days: [ForecastDay], currentEpoch: Int) -> [HourIndexPath] {
        var indices: [HourIndexPath] = []
        outerLoop: for (dayIndex, day) in days.prefix(2).enumerated() {
            innerLoop: for (hourIndex, hour) in day.hour.enumerated() {
                let currentHourEpoch = currentEpoch - (currentEpoch % 3600)
                if hour.timeEpoch >= currentHourEpoch {
                    indices.append(HourIndexPath(dayIndex: dayIndex, hourIndex: hourIndex))
                    if indices.count == 25 {
                        break outerLoop
                    }
                }
            }
        }
        return indices
    }
}
