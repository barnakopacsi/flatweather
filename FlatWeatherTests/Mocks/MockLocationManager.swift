//
//  MockLocationManager.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import Foundation
@testable import FlatWeather

final class MockLocationManager: LocationService {
    var onLocationUpdate: ((Double, Double) -> Void)?
    
    var startCallCount = 0
    
    func startUpdatingLocation() {
        startCallCount += 1
    }
    
    func simulateLocationUpdate(lat: Double, lon: Double) {
        onLocationUpdate?(lat, lon)
    }
}
