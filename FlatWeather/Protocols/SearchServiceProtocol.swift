//
//  SearchServiceProtocol.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 03..
//

import Foundation

protocol SearchService {
    func searchLocations(for query: String) async throws -> [Search]
}
