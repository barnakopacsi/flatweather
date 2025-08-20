//
//  SearchViewModel.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 26..
//

import Foundation

@MainActor
@Observable
class SearchViewModel {
    var errorMessage: String?
    var isSearching = false
    var query = "" {
        didSet {
            handleQueryChange()
        }
    }
    var results: [Search] = []
    var showingErrorAlert = false
    
    func cancelSearch() {
            searchTask?.cancel()
        }
    
    private var searchTask: Task<Void, Error>?
    
    private func handleQueryChange() {
        searchTask?.cancel()
        
        searchTask = Task {
            isSearching = true
            
            try? await Task.sleep(nanoseconds: 250_000_000)
            
            guard !Task.isCancelled else { return }
            
            guard !query.isEmpty else {
                results = []
                isSearching = false
                return
            }
            
            do {
                results = try await searchManager.searchLocations(for: query)
                isSearching = false
                errorMessage = nil
            } catch let urlSessionError as URLSessionError {
                errorMessage = urlSessionError.userFriendlyMessage
            } catch let forecastManagerError as ForecastManagerError {
                errorMessage = forecastManagerError.userFriendlyMessage
            } catch {
                errorMessage = NSLocalizedString("Something went wrong. Please try again.", comment: "")
            }
        }
    }
    
    private let networkManager: NetworkService
    private let savedLocationsManager: SavedLocationsService
    private let searchManager: SearchService
    
    init(
        networkManager: NetworkService,
        savedLocationsManager: SavedLocationsService,
    ) {
        self.networkManager = networkManager
        self.savedLocationsManager = savedLocationsManager
        self.searchManager = SearchManager()
    }
    
    var connectionStatus: ConnectionStatus {
        networkManager.connectionStatus
    }
    
    var savedLocations: [Search] {
        savedLocationsManager.savedLocations
    }
    
    func addLocation(_ location: Search) {
        do {
            try savedLocationsManager.addLocation(location)
            errorMessage = nil
        } catch let savedLocationsManagerError as SavedLocationsManagerError {
            errorMessage = savedLocationsManagerError.userFriendlyMessage
            showingErrorAlert = true
        } catch {
            errorMessage = NSLocalizedString("Something went wrong. Please try again.", comment: "")
            showingErrorAlert = true
        }
    }
    
    func checkInternetConnection() {
        networkManager.checkInternetConnection()
    }
    
    func removeLocation(at index: Int) {
        savedLocationsManager.removeLocation(at: index)
    }
}
