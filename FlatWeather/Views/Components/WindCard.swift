//
//  WindCard.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 19..
//

import SwiftUI

struct WindCard: View {
    let windInfo: (value: String, degree: Int, direction: String, gust: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("WIND", systemImage: "wind")
                .font(.caption)
                .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                Text(windInfo.value)
                    .font(.title)
                HStack {
                    Text("\(windInfo.degree)° \(windInfo.direction)")
                    
                    Image(systemName: "arrow.up")
                        .rotationEffect(.degrees(Double(windInfo.degree + 180)))
                }
                .font(.title2)
            }
            .frame(alignment: .center)
            .fontWeight(.semibold)
            
            Spacer()
            
            Text("Gusts up to \(windInfo.gust)")
                .font(.subheadline)
        }
        .squareShape()
        .weatherComponentBackground()
    }
}

#Preview {
    WindCard(windInfo: (value: "4 mph", degree: 243, direction: "SW", gust: "5 km/h"))
}
