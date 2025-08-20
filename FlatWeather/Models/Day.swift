//
//  Day.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

import Foundation

struct Day: Codable, Equatable, Hashable {
    let condition: Condition
    let dailyChanceOfRain: Int
    let dailyChanceOfSnow: Int
    let maxTempC: Double
    let maxTempF: Double
    let minTempC: Double
    let minTempF: Double
    let totalPrecipIn: Double
    let totalPrecipMm: Double
    
    private enum CodingKeys: String, CodingKey {
        case condition
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case totalPrecipIn = "totalprecip_in"
        case totalPrecipMm = "totalprecip_mm"
    }
}

extension Day {
    func maxTemperature(tempSetting: TemperatureSetting) -> String {
        let value = tempSetting == .celsius ? "\(Int(maxTempC.rounded()))°" : "\(Int(maxTempF.rounded()))°"
        return value
    }
    
    func minTemperature(tempSetting: TemperatureSetting) -> String {
        let value = tempSetting == .celsius ? "\(Int(minTempC.rounded()))°" : "\(Int(minTempF.rounded()))°"
        return value
    }
    
    func totalPrecipation(measurementSetting: MeasurementSetting) -> String {
        let value = measurementSetting == .metric ? "\(Int(totalPrecipMm.rounded())) mm" : String(localized: "\(Int(totalPrecipIn.rounded())) in")
        return value
    }
}

