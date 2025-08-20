//
//  DIContainer.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//
//  Provides and manages app-wide dependencies for the FlatWeather app.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    let dataController: DataService
    let locationManager: LocationService
    let networkManager: NetworkService
    let savedLocationsManager: SavedLocationsService
    let settingsManager: SettingsService
    
    private init() {
        dataController = DataController()
        locationManager = LocationManager()
        networkManager = NetworkManager()
        savedLocationsManager = SavedLocationsManager(dataController: dataController, locationManager: locationManager)
        settingsManager = SettingsManager()
    }
    
    @MainActor
    func makeContentViewModel() -> ContentViewModel {
        ContentViewModel(
            locationManager: locationManager,
            networkManager: networkManager,
            savedLocationsManager: savedLocationsManager,
            settingsManager: settingsManager
        )
    }
    
    @MainActor
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(networkManager: networkManager, savedLocationsManager: savedLocationsManager)
    }
}
