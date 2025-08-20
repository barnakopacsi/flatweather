//
//  MockWeatherResponse.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 14..
//

import Foundation
@testable import FlatWeather

extension WeatherResponse {
    static func mock(lat: Double = 1, lon: Double = 1) -> WeatherResponse {
        var forecastDays: [ForecastDay] = []

        for dayOffset in 0..<3 {
            let dateString = "2025-08-\(14 + dayOffset)"
            
            let dayData = Day(
                condition: Condition(code: 1063),
                dailyChanceOfRain: Int(dayOffset),
                dailyChanceOfSnow: Int(dayOffset),
                maxTempC: 25 + Double(dayOffset),
                maxTempF: 77 + Double(dayOffset),
                minTempC: 15 + Double(dayOffset),
                minTempF: 59 + Double(dayOffset),
                totalPrecipIn: Double(dayOffset),
                totalPrecipMm: Double(dayOffset)
            )
            
            var hours: [Hour] = []
            for hourIndex in 0..<24 {
                let hour = Hour(
                    condition: Condition(code: 1003),
                    chanceOfRain: 0,
                    chanceOfSnow: 0,
                    isDay: hourIndex >= 6 && hourIndex < 18 ? 1 : 0,
                    tempC: 15 + Double(hourIndex),
                    tempF: 59 + Double(hourIndex),
                    time: "\(dateString) \(String(format: "%02d", hourIndex)):00",
                    timeEpoch: 1_755_126_000 + dayOffset * 24 * 3600 + hourIndex * 3600
                )
                hours.append(hour)
            }

            forecastDays.append(ForecastDay(date: dateString, day: dayData, hour: hours))
        }

        return WeatherResponse(
            current: Current(
                condition: Condition(code: 1003),
                feelsLikeC: 25.2,
                feelsLikeF: 77.4,
                gustKph: 13.7,
                gustMph: 8.5,
                humidity: 51,
                isDay: 1,
                precipIn: 0.0,
                precipMm: 0.0,
                tempC: 25.4,
                tempF: 77.6,
                uv: 5.6,
                visKm: 10.0,
                visMiles: 6.0,
                windDegree: 236,
                windDir: "WSW",
                windKph: 11.9,
                windMph: 7.4
            ),
            forecast: Forecast(forecastDay: forecastDays),
            location: Location(
                country: "United Kingdom",
                lat: lat,
                localTime: "2025-08-14 13:23",
                localTimeEpoch: 1755174236,
                lon: lon,
                name: "London",
                region: "City of London, Greater London"
            )
        )
    }
}

