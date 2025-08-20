//
//  HourlyForecastItem.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//

import SwiftUI

struct HourlyForecastItem: View {
    let hour: Hour
    let isFirstCard: Bool
    let isLastCard: Bool
    let tempSetting: TemperatureSetting
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(hour.time.formattedTime(isNow: isFirstCard))
                        .font(.subheadline)
                    
                    VStack(spacing: 0) {
                        Image(systemName: hour.condition.sfSymbol(isDay: hour.isDay))
                            .font(.title2)
                            .frame(minWidth: 45, minHeight: 30)
                        if hour.chanceOfRain > 0 {
                            Text("\(hour.chanceOfRain)%")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(minWidth: 45, minHeight: 50)
                    
                    Text(hour.temperature(tempSetting: tempSetting))
                        .font(.headline)
                }
                
                if !isLastCard {
                    Divider()
                }
            }
        }
    }
}

#Preview {
    let sampleHour = Hour(
        condition: Condition(code: 1087),
        chanceOfRain: 10,
        chanceOfSnow: 0,
        isDay: 1,
        tempC: 25.0,
        tempF: 77.0,
        time: "2025-07-15 14:00",
        timeEpoch: 1753957696
    )
    
    HourlyForecastItem(
        hour: sampleHour,
        isFirstCard: true,
        isLastCard: false,
        tempSetting: .celsius
    )
}
