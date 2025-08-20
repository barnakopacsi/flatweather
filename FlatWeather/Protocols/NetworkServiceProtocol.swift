//
//  NetworkServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//
import Foundation

protocol NetworkService {
    func checkInternetConnection()
    var connectionStatus: ConnectionStatus { get }
}
