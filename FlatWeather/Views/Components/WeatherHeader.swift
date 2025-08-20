//
//  WeatherHeader.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI

struct WeatherHeader: View {
    let currentTemp: String
    let locationName: String
    let locationCountry: String
    let conditionSfSymbol: String
    let isUserLocation: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(currentTemp)
                    .font(.system(size: 60, weight: .bold))
                
                HStack(spacing: 5) {
                    Text(locationName)
                        .font(.title)
                        .lineLimit(1)
                    
                    if isUserLocation {
                        Image(systemName: "location.fill")
                            .font(.callout)
                    }
                }
                
                Text(locationCountry)
                    .font(.subheadline)
            }
            .lineLimit(1)
            
            Spacer()
            
            Image(systemName: conditionSfSymbol)
                .font(.system(size: 100))
        }
        .frame(minHeight: 150)
    }
}

#Preview {
    WeatherHeader(currentTemp: "23", locationName: "Budapest", locationCountry: "Hungary", conditionSfSymbol: "sun.max", isUserLocation: true)
}
