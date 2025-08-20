//
//  UVIndexCard.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 19..
//

import SwiftUI
import Charts

struct UVIndexCard: View {
    let uvInfo: (uvIndex: Int, uvDescription: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("UV INDEX", systemImage: "sun.max")
                .font(.caption)
                .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                Text("\(uvInfo.uvIndex)")
                    .font(.title)
                Text(uvInfo.uvDescription)
                    .font(.title2)
            }
            .fontWeight(.semibold)
            
            Spacer()
            
            Chart {
                RuleMark(
                    xStart: .value("Start", 0),
                    xEnd: .value("End", 11)
                )
                
                PointMark(
                    x: .value("UV INDEX", uvInfo.uvIndex),
                    y: .value("Height", 0)
                )
            }
            .foregroundStyle(.primary)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
        .squareShape()
        .weatherComponentBackground()
    }
}

#Preview {
    UVIndexCard(uvInfo: (uvIndex: 8, uvDescription: "High"))
}
