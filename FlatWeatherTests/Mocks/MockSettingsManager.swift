//
//  MockSettingsManager.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 17..
//

import Foundation
@testable import FlatWeather

@Observable
final class MockSettingsManager: SettingsService {
    var temperatureSetting: TemperatureSetting = .system
    var measurementSetting: MeasurementSetting = .system
    var appearanceSetting: AppearanceSetting = .system
}
