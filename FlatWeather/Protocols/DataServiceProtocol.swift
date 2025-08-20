//
//  DataServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 10..
//

import CoreData

protocol DataService {
    var container: NSPersistentContainer { get }
}
