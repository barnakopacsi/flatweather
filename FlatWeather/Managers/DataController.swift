//
//  DataController.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 10..
//
//  Sets up and manages Core Data in the app.
//

import CoreData
import Foundation

class DataController: DataService {
    let container = NSPersistentContainer(name: "FlatWeatherCD")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            self.container.viewContext.automaticallyMergesChangesFromParent = true
        }
    }
}
