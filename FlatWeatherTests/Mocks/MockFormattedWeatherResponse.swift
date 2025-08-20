//
//  MockFormattedWeatherResponse.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import Foundation
@testable import FlatWeather

extension FormattedWeatherResponse {
    static func mock(
        raw: WeatherResponse = .mock(),
        fetchedAt: Date = Date(),
        isUserLocation: Bool = false,
        id: Int
    ) -> FormattedWeatherResponse {
        FormattedWeatherResponse(
            from: raw,
            fetchedAt: fetchedAt,
            isUserLocation: isUserLocation,
            id: id
        )
    }
}
