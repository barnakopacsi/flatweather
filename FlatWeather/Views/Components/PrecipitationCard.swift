//
//  PrecipitationCard.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 19..
//

import SwiftUI

struct PrecipitationCard: View {
    let todayPrecip: String
    let tomorrowPrecip: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("PRECIPITATION", systemImage: "drop")
                .font(.caption)
                .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                Text(todayPrecip)
                    .font(.title)
                Text("Today")
                    .font(.title2)
            }
            .fontWeight(.semibold)
            
            Spacer()
            
            Text("\(tomorrowPrecip) expected tomorrow")
                .font(.subheadline)
        }
        .squareShape()
        .weatherComponentBackground()
    }
}


#Preview {
    PrecipitationCard(todayPrecip: "5 mm", tomorrowPrecip: "6 in")
}
