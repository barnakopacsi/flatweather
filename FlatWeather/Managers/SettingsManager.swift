//
//  SettingsManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 27..
//
//  Manages app settings like temperature, measurement, and appearance.
//

import Foundation
import SwiftUI

final class SettingsManager: SettingsService, ObservableObject {
    @AppStorage("temperatureSetting") var temperatureSetting: TemperatureSetting = .system
    @AppStorage("measurementSetting") var measurementSetting: MeasurementSetting = .system
    @AppStorage("appearanceSetting") var appearanceSetting: AppearanceSetting = .system
}

enum TemperatureUnit {
    case celsius, fahrenheit
}

enum TemperatureSetting: String, CaseIterable {
    case celsius, fahrenheit, system
    
    var resolvedValue: TemperatureUnit {
        switch self {
        case .celsius:
            return .celsius
        case .fahrenheit:
            return .fahrenheit
        case .system:
            return Locale.current.measurementSystem == .metric ? .celsius : .fahrenheit
        }
    }
    
    var displayName: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .system:
            return NSLocalizedString("System Setting", comment: "")
        }
    }
    
    var systemImage: String {
        switch self {
        case .celsius: return "degreesign.celsius"
        case .fahrenheit: return "degreesign.fahrenheit"
        case .system: return "gearshape"
        }
    }
}

enum MeasurementUnit {
    case imperial, metric
}

enum MeasurementSetting: String, CaseIterable {
    case imperial, metric, system
    
    var resolvedValue: MeasurementUnit {
        switch self {
        case .imperial:
            return .imperial
        case .metric:
            return .metric
        case .system:
            return Locale.current.measurementSystem == .metric ? .metric : .imperial
        }
    }
    
    var displayName: String {
        switch self {
        case .imperial:
            return NSLocalizedString("Imperial", comment: "")
        case .metric:
            return NSLocalizedString("Metric", comment: "")
        case .system:
            return NSLocalizedString("System Setting", comment: "")
        }
    }
    
    var systemImage: String {
        switch self {
        case .imperial: return "mph"
        case .metric: return "kph"
        case .system: return "gearshape"
        }
    }
}

enum AppearanceSetting: String, CaseIterable {
    case dark, light, system
    
    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
    var displayName: String {
        switch self {
        case .dark:
            return NSLocalizedString("Dark Mode", comment: "")
        case .light:
            return NSLocalizedString("Light Mode", comment: "")
        case .system:
            return NSLocalizedString("System Setting", comment: "")
        }
    }
    
    var systemImage: String {
        switch self {
        case .dark: return "moon"
        case .light: return "sun.max"
        case .system: return "gearshape"
        }
    }
}
