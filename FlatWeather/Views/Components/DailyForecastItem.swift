//
//  DailyForecastItem.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//

import SwiftUI

struct DailyForecastItem: View {
    let forecastDay: ForecastDay
    let isFirstItem: Bool
    let tempSetting: TemperatureSetting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if isFirstItem {
                Label("3-DAY FORECAST", systemImage: "calendar")
                    .font(.caption)
                    .frame(alignment: .leading)
            }
            
            Divider()
            
            HStack {
                Text(forecastDay.date.formattedDay(isToday: isFirstItem))
                    .fontWeight(.medium)
                    .frame(minWidth: 95, alignment: .leading)
                
                HStack(spacing: 5) {
                    Image(systemName: forecastDay.day.condition.sfSymbol(isDay: 1))
                    
                    if forecastDay.day.dailyChanceOfRain > 0 {
                        Text("\(forecastDay.day.dailyChanceOfRain)%")
                            .font(.callout)
                    }
                }
                .fontWeight(.medium)
                
                Spacer()
                
                Text("Min \(forecastDay.day.minTemperature(tempSetting: tempSetting)) / Max \(forecastDay.day.maxTemperature(tempSetting: tempSetting))")
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    let sampleCondition = Condition(code: 1000)
    
    let sampleHour = [Hour(condition: sampleCondition, chanceOfRain: 10, chanceOfSnow: 0, isDay: 1, tempC: 25.0, tempF: 77.0, time: "2025-07-16 14:00", timeEpoch: 1753957696)]
    
    let sampleDay = Day(/*avgHumidity: 0, avgTempC: 15, avgTempF: 30,avgVisKm: 0, avgVisMiles: 0,*/ condition: sampleCondition, dailyChanceOfRain: 10, dailyChanceOfSnow: 0, maxTempC: 25, maxTempF: 50/*, maxWindKph: 20, maxWindMph: 10*/, minTempC: 10, minTempF: 20, totalPrecipIn: 1, totalPrecipMm: 1,/* totalSnowCm: 0,*//* uv: 2*/)
    
    let sampleForecastDay = ForecastDay(date: "2025-07-16", day: sampleDay, hour: sampleHour)
    
    DailyForecastItem(forecastDay: sampleForecastDay, isFirstItem: true, tempSetting: .celsius)
}
