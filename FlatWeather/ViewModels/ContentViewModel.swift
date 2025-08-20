//
//  ContentViewModel.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 23..
//

import Foundation

@MainActor
@Observable
final class ContentViewModel {
    var errorMessage: String?
    var existingResponses: [FormattedWeatherResponse] = []
    var selectedLocationIndex: Int {
            existingResponses.firstIndex { $0.id == selectedLocationID } ?? 0
        }
    var showingDeleteAlert = false
    var showingErrorAlert = false
    var showingSearchView = false
    var selectedLocationID: Int?
    
    private let locationManager: LocationService
    private let networkManager: NetworkService
    private let savedLocationsManager: SavedLocationsService
    private var settingsManager: SettingsService
    private let forecastManager: ForecastService
    
    init(
        locationManager: LocationService,
        networkManager: NetworkService,
        savedLocationsManager: SavedLocationsService,
        settingsManager: SettingsService
    ) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.savedLocationsManager = savedLocationsManager
        self.settingsManager = settingsManager
        self.forecastManager = ForecastManager()
    }
    
    var appearanceSetting: AppearanceSetting {
        get { settingsManager.appearanceSetting }
        set { settingsManager.appearanceSetting = newValue }
    }
    
    var connectionStatus: ConnectionStatus {
        networkManager.connectionStatus
    }
    
    var measurementSetting: MeasurementSetting {
        get { settingsManager.measurementSetting }
        set { settingsManager.measurementSetting = newValue }
    }
    
    var savedLocations: [Search] {
        savedLocationsManager.savedLocations
    }
    
    var temperatureSetting: TemperatureSetting {
        get { settingsManager.temperatureSetting }
        set { settingsManager.temperatureSetting = newValue }
    }
    
    func checkInternetConnection() {
        networkManager.checkInternetConnection()
    }
    
    func refreshWeatherData() async {
        do {
            existingResponses = try await forecastManager.grabAllLocationWeather(locations: savedLocations, existingResponses: existingResponses)
            errorMessage = nil
        } catch let urlSessionError as URLSessionError {
            errorMessage = urlSessionError.userFriendlyMessage
            showingErrorAlert = true
        } catch let forecastManagerError as ForecastManagerError {
            errorMessage = forecastManagerError.userFriendlyMessage
            showingErrorAlert = true
        } catch {
            errorMessage = NSLocalizedString("Something went wrong. Please try again.", comment: "")
            showingErrorAlert = true
        }
    }
    
    func removeLocation(at index: Int) {
        if index < existingResponses.count - 1 {
            selectedLocationID = existingResponses[index + 1].id
        } else {
            selectedLocationID = existingResponses[existingResponses.count - 1].id
        }
        
        savedLocationsManager.removeLocation(at: index)
    }
}
