//
//  Location.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//

struct Location: Codable, Equatable, Hashable {
    let country: String
    let lat: Double
    let localTime: String
    let localTimeEpoch: Int
    let lon: Double
    let name: String
    let region: String
    
    private enum CodingKeys: String, CodingKey {
        case country, lat, lon, name, region
        case localTime = "localtime"
        case localTimeEpoch = "localtime_epoch"
    }
}
