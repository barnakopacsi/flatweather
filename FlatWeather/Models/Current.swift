//
//  Current.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

import Foundation

struct Current: Codable, Equatable, Hashable {
    let condition: Condition
    let feelsLikeC: Double
    let feelsLikeF: Double
    let gustKph: Double
    let gustMph: Double
    let humidity: Int
    let isDay: Int
    let precipIn: Double
    let precipMm: Double
    let tempC: Double
    let tempF: Double
    let uv: Double
    let visKm: Double
    let visMiles: Double
    let windDegree: Int
    let windDir: String
    let windKph: Double
    let windMph: Double
    
    private enum CodingKeys: String, CodingKey {
        case condition, humidity, uv
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case gustKph = "gust_kph"
        case gustMph = "gust_mph"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case precipIn = "precip_in"
        case precipMm = "precip_mm"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case windKph = "wind_kph"
        case windMph = "wind_mph"
    }
}

extension Current {
    func feelsLike(tempSetting: TemperatureSetting) -> String {
        let value = tempSetting == .celsius ? "\(Int(feelsLikeC.rounded()))°" : "\(Int(feelsLikeF.rounded()))°"
        return value
    }
    
    func gust(measurementSetting: MeasurementSetting) -> String {
        let value = measurementSetting == .metric ? "\(Int(gustKph.rounded())) km/h" : "\(Int(gustMph.rounded())) mph"
        return value
    }
    
    var humidityDescription: String {
        switch humidity {
        case ..<30:
            return NSLocalizedString("The air may feel dry.", comment: "")
        case 30..<61:
            return NSLocalizedString("The air should feel comfortable.", comment: "")
        case 61..<81:
            return NSLocalizedString("The air may feel muggy.", comment: "")
        default:
            return NSLocalizedString("The air may feel uncomfortable.", comment: "")
        }
    }
    
    var humidityInfo: (value: Int, level: String, description: String) {
        return (humidity, humidityLevel, humidityDescription)
    }
    
    var humidityLevel: String {
        switch humidity {
        case ..<30:
            return NSLocalizedString("Low", comment: "")
        case 30..<61:
            return NSLocalizedString("Optimal", comment: "")
        case 61..<81:
            return NSLocalizedString("High", comment: "")
        default:
            return NSLocalizedString("Very high", comment: "")
        }
    }
    
    func temperature(tempSetting: TemperatureSetting) -> String {
        let value = tempSetting == .celsius ? "\(Int(tempC.rounded()))°" : "\(Int(tempF.rounded()))°"
        return value
    }
    
    var uvDescription: String {
        switch uv {
        case ..<3:
            return NSLocalizedString("Low", comment: "")
        case 3..<6:
            return NSLocalizedString("Moderate", comment: "")
        case 6..<8:
            return NSLocalizedString("High", comment: "")
        case 8..<11:
            return NSLocalizedString("Very High", comment: "")
        default:
            return NSLocalizedString("Extreme", comment: "")
        }
    }
    
    var uvIndex: Int {
        Int(uv)
    }
    
    var uvInfo: (uvIndex: Int, uvDescription: String) {
        return (uvIndex, uvDescription)
    }
    
    func visibility(measurementSetting: MeasurementSetting) -> String {
        let value = measurementSetting == .metric ? "\(Int(visKm.rounded())) km" : String(localized: "\(Int(visMiles.rounded())) mi")
        return value
    }
    
    func visibilityDescription(visibility: Double, measurementSetting: MeasurementSetting) -> String {
        switch measurementSetting.resolvedValue {
        case .imperial:
            switch visibility {
            case ..<0.6:
                return NSLocalizedString("It may be hard to see far ahead.", comment: "")
            case 0.6..<2.5:
                return NSLocalizedString("Outdoor conditions may feel hazy.", comment: "")
            case 2.5..<6.2:
                return NSLocalizedString("You should be able to see a good distance.", comment: "")
            case 6.2..<12.4:
                return NSLocalizedString("Most things are clearly visible.", comment: "")
            default:
                return NSLocalizedString("The visibility is excellent.", comment: "")
            }
            
        case .metric:
            switch visibility {
            case ..<1:
                return NSLocalizedString("It may be hard to see far ahead.", comment: "")
            case 1..<4:
                return NSLocalizedString("Outdoor conditions may feel hazy.", comment: "")
            case 4..<10:
                return NSLocalizedString("You should be able to see a good distance.", comment: "")
            case 10..<20:
                return NSLocalizedString("Most things are clearly visible.", comment: "")
            default:
                return NSLocalizedString("The air is very clear.", comment: "")
            }
        }
    }
    
    func visibilityInDouble(measurementSetting: MeasurementSetting) -> Double {
        let value = measurementSetting == .metric ? visKm : visMiles
        return value
    }
    
    func visibilityInfo(measurementSetting: MeasurementSetting) -> (value: String, level: String, description: String) {
        let rawValue = visibilityInDouble(measurementSetting: measurementSetting)
        return (
            visibility(measurementSetting: measurementSetting),
            visibilityLevel(visibility: rawValue, measurementSetting: measurementSetting),
            visibilityDescription(visibility: rawValue, measurementSetting: measurementSetting)
        )
    }
    
    func visibilityLevel(visibility: Double, measurementSetting: MeasurementSetting) -> String {
        switch measurementSetting.resolvedValue {
        case .imperial:
            switch visibility {
            case ..<0.6:
                return NSLocalizedString("Very low", comment: "")
            case 0.6..<2.5:
                return NSLocalizedString("Limited", comment: "")
            case 2.5..<6.2:
                return NSLocalizedString("Fair", comment: "")
            case 6.2..<12.4:
                return NSLocalizedString("Good", comment: "")
            default:
                return NSLocalizedString("Excellent", comment: "")
            }
            
        case .metric:
            switch visibility {
            case ..<1:
                return NSLocalizedString("Very low", comment: "")
            case 1..<4:
                return NSLocalizedString("Limited", comment: "")
            case 4..<10:
                return NSLocalizedString("Fair", comment: "")
            case 10..<20:
                return NSLocalizedString("Good", comment: "")
            default:
                return NSLocalizedString("Excellent", comment: "")
            }
        }
    }
    
    func wind(measurementSetting: MeasurementSetting) -> String {
        let value = measurementSetting == .metric ? "\(Int(windKph.rounded())) km/h" : "\(Int(windMph.rounded())) mph"
        return value
    }
    
    func windInfo(measurementSetting: MeasurementSetting) -> (value: String, degree: Int, direction: String, gust: String) {
        return (wind(measurementSetting: measurementSetting), windDegree, windDir, gust(measurementSetting: measurementSetting))
    }
}

