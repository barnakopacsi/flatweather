//
//  TabPageIndicator.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 11..
//

import SwiftUI

struct TabPageIndicator: View {
    let numberOfLocations: Int
    let selectedLocationIndex: Int
    let userLocationIndex: Int?

    var body: some View {
        VStack {
            Divider()
            
            HStack {
                ForEach(0..<numberOfLocations, id: \.self) { index in
                    if index == userLocationIndex{
                        Image(systemName: "location.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(index == selectedLocationIndex ? .primary : .secondary)
                    } else {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(index == selectedLocationIndex ? .primary : .secondary)
                    }
                }
                .padding(.top, 2)
                .animation(.easeInOut, value: selectedLocationIndex)
            }
        }
    }
}

#Preview {
    TabPageIndicator(numberOfLocations: 3, selectedLocationIndex: 0, userLocationIndex: 0)
}
