//
//  ForecastDay.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

struct ForecastDay: Codable, Equatable, Hashable, Identifiable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    var id: String { date }
}
