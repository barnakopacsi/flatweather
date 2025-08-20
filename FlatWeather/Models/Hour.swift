//
//  Hour.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

struct Hour: Codable, Equatable, Hashable, Identifiable {
    let condition: Condition
    let chanceOfRain: Int
    let chanceOfSnow: Int
    let isDay: Int
    let tempC: Double
    let tempF: Double
    let time: String
    let timeEpoch: Int
    
    var id: String { time }
    
    private enum CodingKeys: String, CodingKey {
        case condition, time
        case chanceOfRain = "chance_of_rain"
        case chanceOfSnow = "chance_of_snow"
        case isDay = "is_day"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case timeEpoch = "time_epoch"
    }
}

extension Hour {
    func temperature(tempSetting: TemperatureSetting) -> String {
        let value = tempSetting == .celsius ? "\(Int(tempC.rounded()))°" : "\(Int(tempF.rounded()))°"
        return value
    }
}

