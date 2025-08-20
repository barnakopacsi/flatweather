//
//  Condition.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

struct Condition: Codable, Equatable, Hashable {
    let code: Int
}

extension Condition {
    func sfSymbol(isDay: Int) -> String {
        let isDayTime = isDay == 1
        
        switch code {
        case 1000: return isDayTime ? "sun.max" : "moon.stars"
        case 1003: return isDayTime ? "cloud.sun" : "cloud.moon"
        case 1006, 1009: return "cloud"
        case 1030, 1135, 1147: return "cloud.fog"
        case 1063, 1180, 1183, 1186, 1189, 1240: return "cloud.rain"
        case 1192, 1195, 1243, 1246: return "cloud.heavyrain"
        case 1066, 1210, 1213, 1216, 1219, 1222, 1225, 1255, 1258: return "cloud.snow"
        case 1087, 1273, 1276: return "cloud.bolt.rain"
        case 1279, 1282: return "cloud.bolt.snow"
        default: return "cloud"
        }
    }
}
