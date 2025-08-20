//
//  HumidityCard.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 19..
//

import SwiftUI

struct HumidityCard: View {
    let humidityInfo: (value: Int, level: String, description: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("HUMIDITY", systemImage: "humidity")
                .font(.caption)
                .padding(.bottom, 8)
            
            
            Text("\(humidityInfo.value)%")
                .font(.title)
                .fontWeight(.semibold)
            
            Text(humidityInfo.level)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(humidityInfo.description)
                .font(.subheadline)
        }
        .squareShape()
        .weatherComponentBackground()
    }
}


#Preview {
    HumidityCard(humidityInfo: (value: 20, level: "Low", description: "Low humidity."))
}
