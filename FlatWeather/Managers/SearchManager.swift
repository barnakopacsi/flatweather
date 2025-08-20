//
//  SearchManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//
//  Handles location search using WeatherAPI.
//

import Foundation

struct SearchManager: SearchService {
    private let apiKey = Config.weatherAPIKey
    
    func searchLocations(for query: String) async throws -> [Search] {
            let urlString = "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(query)"

            guard let url = URL(string: urlString) else {
                throw SearchManagerError.invalidURL
            }
            
            let locations = try await URLSession.shared.decode([Search].self, from: url)
            return locations
    }
    

}

enum SearchManagerError: Error {
    case invalidURL
    
    var userFriendlyMessage: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("One of the locations could not be found. Please try again later.", comment: "")
        }
    }
}
