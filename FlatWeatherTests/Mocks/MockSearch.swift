//
//  MockSearch.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 14..
//

import Foundation
@testable import FlatWeather

extension Search {
    static func mock(country: String = "", id: Int = 1, lat: Double = 51.5171, lon: Double = -0.1062, name: String = "Test", region: String = "") -> Search {
        Search(country: country, id: id, lat: lat, lon: lon, name: name, region: region)
    }
}
