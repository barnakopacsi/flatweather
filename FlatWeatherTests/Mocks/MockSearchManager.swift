//
//  MockSearchManager.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 16..
//

import Foundation
@testable import FlatWeather

class MockSearchManager: SearchService {
    var callCount = 0
    var shouldThrowInvalidURLError = false
    
    func searchLocations(for query: String) async throws -> [Search] {
        callCount += 1
        if shouldThrowInvalidURLError {
            throw SearchManagerError.invalidURL
        }
        return [Search.mock(name: query)]
    }
}
