//
//  SavedLocationsServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//

import Foundation

protocol SavedLocationsService {
    var savedLocations: [Search] { get set }
    func addLocation(_ location: Search) throws
    func removeLocation(at index: Int)
}
