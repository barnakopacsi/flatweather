//
//  SavedLocationsManagerTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import CoreData
import XCTest
@testable import FlatWeather

final class SavedLocationsManagerTests: XCTestCase {
    func testLoadSavedLocations_thereAreSavedLocations_populatesFromCoreData() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let context = mockDataController.container.viewContext
        let entity = SearchEntity(context: context)
        entity.id = 123
        entity.lat = 50.0
        entity.lon = 10.0
        entity.name = "Test City"
        entity.country = "Testland"
        entity.region = "Test Region"
        try? context.save()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        XCTAssertEqual(manager.savedLocations.count, 1)
        XCTAssertEqual(manager.savedLocations.first?.name, "Test City")
    }
    
    func testAddDefaultLocation_noSavedLocations_addsDefaultLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        XCTAssertEqual(manager.savedLocations.count, 1)
        XCTAssertEqual(manager.savedLocations.first?.name, "London")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            
            XCTAssertEqual(results.count, 1)
            XCTAssertEqual(results.first?.name, "London")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddLocation_savesLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        do {
            try manager.addLocation(Search.mock(name: "Test"))
            XCTAssertEqual(manager.savedLocations.count, 2)
            XCTAssertEqual(manager.savedLocations[1].name, "Test")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            
            XCTAssertEqual(results.count, 2)
            XCTAssertEqual(results[1].name, "Test")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testRemoveLocation_withAtLeast2Locations_removesLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        let testLocation = Search.mock(name: "Test")
        try? manager.addLocation(testLocation)
        
        XCTAssertEqual(manager.savedLocations.count, 2, "Default and test locations should be in the array")
        
        manager.removeLocation(at: 1)
        
        XCTAssertEqual(manager.savedLocations.count, 1, "Only one location should remain in the array")
        XCTAssertEqual(manager.savedLocations.first?.name, "London", "Remaining location should be London")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 1, "Only one location should remain in CoreData")
            XCTAssertEqual(results.first?.name, "London", "Remaining location should be London")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testRemoveLocation_withOnlyOneLocation_doesNotRemoveLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        XCTAssertEqual(manager.savedLocations.count, 1, "Default location should be in the array")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 1, "Default location should be in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        manager.removeLocation(at: 0)
        
        XCTAssertEqual(manager.savedLocations.count, 1, "Default location should remain in the array")
        
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 1, "Default location should remain in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddLocation_withExistingLocation_doesNotAddLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertTrue(results.contains(where: { $0.id == 2801268 }), "Make sure default location (id: 2801268) is already in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(manager.savedLocations.contains(where: { $0.id == 2801268 }), true, "Make sure default location (id: 2801268) is already in the array")
        
        let testLocation = Search.mock(id: 2801268)
        try? manager.addLocation(testLocation)
        
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 1, "Location with id 2801268 should not be added again to CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(manager.savedLocations.count, 1, "Location with id 2801268 should not be added again to the array")
    }
    
    func testAddLocation_withMaxLocationNumber_doesNotAddLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        for i in 0..<11 {
            try? manager.addLocation(Search.mock(id: i))
        }
        
        XCTAssertEqual(manager.savedLocations.count, 12, "12 locations should be in the array")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 12, "12 locations should be in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        try? manager.addLocation(Search.mock(id: 100))
        
        XCTAssertEqual(manager.savedLocations.count, 12, "13th location should not be added to the array")
        XCTAssertFalse(manager.savedLocations.contains(where: { $0.id == 100 }), "A location with the id 100 should not be in the array")
        
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 12, "13th location should not be added to CoreData")
            XCTAssertFalse(results.contains(where: { $0.id == 100 }), "A location with the id 100 should not be in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddOrUpdateUserLocation_whenNotExisting_addsUserLocationAtFirstIndex() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        XCTAssertEqual(mockLocationManager.startCallCount, 1, "Location tracking should start by initializing SavedLocationsManager")
        
        mockLocationManager.simulateLocationUpdate(lat: 47.5, lon: 19.0)
        
        XCTAssertEqual(manager.savedLocations.first?.name, "User Location", "'User Location' should be in the array at the first index")
        XCTAssertEqual(manager.savedLocations.first?.lat, 47.5)
        XCTAssertEqual(manager.savedLocations.first?.lon, 19.0)
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertTrue(results.contains(where: { $0.name == "User Location" && $0.lat == 47.5 && $0.lon == 19.0 }), "'User Location' should be in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddOrUpdateUserLocation_whenExisting_updatesCoordinatesAndKeepsAtFirstIndex() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        mockLocationManager.simulateLocationUpdate(lat: 47.5, lon: 19.0)
        
        XCTAssertEqual(manager.savedLocations.first?.lat, 47.5)
        XCTAssertEqual(manager.savedLocations.first?.lon, 19.0)
        
        mockLocationManager.simulateLocationUpdate(lat: 48.0, lon: 20.0)
        
        XCTAssertEqual(manager.savedLocations.first?.name, "User Location", "Should still be 'User Location'")
        XCTAssertEqual(manager.savedLocations.first?.lat, 48.0, "Latitude should be updated")
        XCTAssertEqual(manager.savedLocations.first?.lon, 20.0, "Longitude should be updated")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertTrue(results.contains { $0.name == "User Location" && $0.lat == 48.0 && $0.lon == 20.0 }, "'User Location' should be updated in CoreData")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddOrUpdateUserLocation_whenNonExistingAndMaxLocations_replacesLastLocation() {
        let mockDataController = MockDataController()
        let mockLocationManager = MockLocationManager()
        
        let manager = SavedLocationsManager(dataController: mockDataController, locationManager: mockLocationManager)
        
        for i in 1..<12 {
            try? manager.addLocation(Search.mock(id: i))
        }
        
        XCTAssertEqual(manager.savedLocations.count, 12, "Array should have 12 locations")
        XCTAssert(manager.savedLocations.last?.id == 11, "Last location's id should be '11'")
        
        mockLocationManager.simulateLocationUpdate(lat: 47.5, lon: 19.0)
        
        XCTAssertEqual(manager.savedLocations.first?.name, "User Location", "User Location should be at index 0")
        XCTAssertEqual(manager.savedLocations.count, 12, "Array should still have 12 locations")
        XCTAssertFalse(manager.savedLocations.contains(where: { $0.id == 11 }), "The last location should be removed to keep max count")
        
        let request: NSFetchRequest<SearchEntity> = SearchEntity.fetchRequest()
        do {
            let results = try mockDataController.container.viewContext.fetch(request)
            XCTAssertEqual(results.count, 12, "Core Data should also have 12 locations")
            XCTAssertTrue(results.contains { $0.name == "User Location" && $0.lat == 47.5 && $0.lon == 19.0 }, "User Location should exist in Core Data")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
