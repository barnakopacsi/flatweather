//
//  MockNetworkManager.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import Foundation
@testable import FlatWeather

@Observable
final class MockNetworkManager: NetworkService {
    var connectionStatus: ConnectionStatus = .undetermined
    var callCount = 0
    
    func checkInternetConnection() {
        callCount += 1
    }
}
