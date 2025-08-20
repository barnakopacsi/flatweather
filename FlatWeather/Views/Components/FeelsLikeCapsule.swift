//
//  FeelsLikeCapsule.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI

struct FeelsLikeCapsule: View {
    let feelsLike: String
    let dailyHigh: String
    let dailyLow: String
    
    var body: some View {
        Label("Feels like \(feelsLike) / H: \(dailyHigh) L: \(dailyLow)", systemImage: "thermometer.variable")
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .weatherComponentBackground()
    }
}

#Preview {
    FeelsLikeCapsule(feelsLike: "40", dailyHigh: "45", dailyLow: "26")
}
