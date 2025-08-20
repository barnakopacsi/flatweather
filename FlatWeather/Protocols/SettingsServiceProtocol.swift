//
//  SettingsServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//

import Foundation

protocol SettingsService {
    var temperatureSetting: TemperatureSetting { get set }
    var measurementSetting: MeasurementSetting { get set }
    var appearanceSetting: AppearanceSetting { get set }    
}
