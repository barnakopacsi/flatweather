//
//  Search.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//

import Foundation

struct Search: Codable, Equatable, Identifiable {
    let country: String
    let id: Int
    let lat: Double
    let lon: Double
    let name: String
    let region: String
    
    private enum CodingKeys: String, CodingKey {
        case country, id, lat, lon, name, region
    }
    
    var createdAt: Date = Date()
}
