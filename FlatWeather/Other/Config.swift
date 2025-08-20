// Config.swift
// FlatWeather
//
// Contains app-wide constants like API keys.

import Foundation

struct Config {
    static var weatherAPIKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["WeatherAPIKey"] as? String else {
            fatalError("WeatherAPIKey not found in Config.plist")
        }
        return key
    }
}
