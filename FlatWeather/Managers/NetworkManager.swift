//
//  NetworkManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 23..
//
//  Monitors the network connection status using NWPathMonitor.
//

import Foundation
import Network

@Observable
final class NetworkManager: NetworkService {
    var connectionStatus: ConnectionStatus = .undetermined
    
    func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetCheck")
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.connectionStatus = path.status == .satisfied ? .connected : .disconnected
            }
        }
        
        monitor.start(queue: queue)
    }
}

enum ConnectionStatus {
    case connected, disconnected, undetermined
}
