//
//  URLSessionExtension.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//
//  Adds a convenience method to download and decode JSON data from a URL.
//

import Foundation

extension URLSession {
    func decode<T: Decodable>(_ type: T.Type = T.self, from url: URL) async throws -> T {
        do {
            let (data, response) = try await data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                throw URLSessionError.serverError(statusCode: httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch let error as DecodingError {
            throw URLSessionError.dataDecodingFailure(underlying: error)
        } catch {
            throw URLSessionError.dataFetchFailure(underlying: error)
        }
    }
}

enum URLSessionError: Error {
    case dataFetchFailure(underlying: Error)
    case dataDecodingFailure(underlying: Error)
    case serverError(statusCode: Int)
    
    var userFriendlyMessage: String {
        switch self {
        case .dataFetchFailure:
            return NSLocalizedString("Could not connect to the server. Please check your internet.", comment: "")
        case .serverError(let status):
            return NSLocalizedString("The server responded with an error: \(status).", comment: "")
        case .dataDecodingFailure:
            return NSLocalizedString("Received unexpected data from the server.", comment: "")
        }
    }
}
