//
//  VisibilityCard.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 19..
//

import SwiftUI

struct VisibilityCard: View {
    let visibilityInfo: (value: String, level: String, description: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("VISIBILITY", systemImage: "eye")
                .font(.caption)
                .padding(.bottom, 8)
            
            Text(visibilityInfo.value)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(visibilityInfo.level)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(visibilityInfo.description)
                .font(.subheadline)
        }
        .squareShape()
        .weatherComponentBackground()
    }
}

#Preview {
    VisibilityCard(visibilityInfo: (value: "5 km", level: "Good", description: "Clear views."))
}
