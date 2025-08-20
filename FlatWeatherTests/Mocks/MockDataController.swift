//
//  MockDataController.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 15..
//

import CoreData
import Foundation
@testable import FlatWeather

final class MockDataController: DataService {
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FlatWeatherCD")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}
