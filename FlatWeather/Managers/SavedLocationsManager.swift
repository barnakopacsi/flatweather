//
//  SavedLocationsManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 12..
//
//  Manages saved locations, including adding, removing, updating the user location, and loading defaults.
//

import Foundation
import CoreData

@Observable
final class SavedLocationsManager: SavedLocationsService {
    private var dataController: DataService
    private var locationManager: LocationService
    
    init(dataController: DataService, locationManager: LocationService) {
        self.dataController = dataController
        self.locationManager = locationManager
        
        self.locationManager.onLocationUpdate = { [weak self] lat, lon in
            self?.addOrUpdateUserLocation(lat: lat, lon: lon)
        }
        
        locationManager.startUpdatingLocation()
        loadSavedLocations()
        
        
        if savedLocations.isEmpty {
            addDefaultLocation()
        }
    }
    
    var savedLocations: [Search] = []
    
    private func loadSavedLocations() {
        let request = SearchEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        let entities = fetchContext(request: request)
        savedLocations = entities.map { entity in
            Search(
                country: entity.country ?? "",
                id: Int(entity.id),
                lat: entity.lat,
                lon: entity.lon,
                name: entity.name ?? "",
                region: entity.region ?? "",
                createdAt: entity.createdAt ?? Date()
            )
        }
    }
    
    func addLocation(_ location: Search) throws {
        guard !savedLocations.contains(where: { $0.id == location.id }) else { return }
        guard savedLocations.count < 12 else {
            throw SavedLocationsManagerError.maxLocationsReached
        }
        
        let entity = SearchEntity(context: dataController.container.viewContext)
        entity.country = location.country
        entity.id = Int64(location.id)
        entity.lat = location.lat
        entity.lon = location.lon
        entity.name = location.name
        entity.region = location.region
        entity.createdAt = location.createdAt
        
        saveContext()
        savedLocations.append(location)
    }
    
    private func addOrUpdateUserLocation(lat: Double, lon: Double) {
        let request = SearchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", "User Location")
        
        let entities = fetchContext(request: request)
        
        if let existing = entities.first {
            existing.lat = lat
            existing.lon = lon
            saveContext()
            
            if let index = savedLocations.firstIndex(where: { $0.name == "User Location" }) {
                let old = savedLocations[index]
                let updated = Search(
                    country: old.country,
                    id: old.id,
                    lat: lat,
                    lon: lon,
                    name: old.name,
                    region: old.region,
                    createdAt: old.createdAt
                )
                savedLocations[index] = updated
                
                if index != 0 {
                    savedLocations.remove(at: index)
                    savedLocations.insert(updated, at: 0)
                }
            }
        } else {
            let userLocation = Search(
                country: "",
                id: UUID().hashValue,
                lat: lat,
                lon: lon,
                name: "User Location",
                region: "",
                createdAt: Date()
            )
            do {
                try addLocation(userLocation)
            } catch {
                removeLocation(at: savedLocations.count - 1)
                try? addLocation(userLocation)
            }
            
            if let index = savedLocations.firstIndex(where: { $0.name == "User Location" }), index != 0 {
                let loc = savedLocations.remove(at: index)
                savedLocations.insert(loc, at: 0)
            }
        }
    }
    
    func removeLocation(at index: Int) {
        guard savedLocations.count > 1 else { return }
        guard index < savedLocations.count else { return }
        
        let locationToRemove = savedLocations[index]
        
        let request = SearchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", locationToRemove.id)
        
        let entities = fetchContext(request: request)
        if let entityToDelete = entities.first {
            dataController.container.viewContext.delete(entityToDelete)
            saveContext()
            savedLocations.remove(at: index)
        }
    }
    
    private func addDefaultLocation() {
        let defaultLocation = Search(
            country: "United Kingdom",
            id: 2801268,
            lat: 51.52,
            lon: -0.11,
            name: "London",
            region: "City of London, Greater London",
            createdAt: Date()
        )
        try? addLocation(defaultLocation)
    }
    
    private func fetchContext(request: NSFetchRequest<SearchEntity>) -> [SearchEntity] {
        do {
            return try dataController.container.viewContext.fetch(request)
        } catch {
            print("Error fetching context: \(error)")
            return []
        }
    }
    
    private func saveContext() {
        do {
            try dataController.container.viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

enum SavedLocationsManagerError: Error {
    case maxLocationsReached
    
    var userFriendlyMessage: String {
        switch self {
        case .maxLocationsReached:
            return NSLocalizedString("Maximum number of saved locations reached. Please remove locations to add new ones.", comment: "")
        }
    }
}
