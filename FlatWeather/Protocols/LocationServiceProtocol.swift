//
//  LocationServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 11..
//

protocol LocationService {
    var onLocationUpdate: ((Double, Double) -> Void)? { get set }
    func startUpdatingLocation()
}
