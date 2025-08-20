//
//  WeatherView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//

import SwiftUI

struct WeatherView: View {
    let weatherData: FormattedWeatherResponse
    let temperatureSetting: TemperatureSetting
    let measurementSetting: MeasurementSetting
    let isScrollDisabled: Bool
    
    var body: some View {
        VStack {
            WeatherHeader(
                currentTemp: weatherData.current.temperature(tempSetting: temperatureSetting),
                locationName: weatherData.location.name,
                locationCountry: weatherData.location.country,
                conditionSfSymbol: weatherData.current.condition.sfSymbol(isDay: weatherData.current.isDay),
                isUserLocation: weatherData.isUserLocation
            )
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    FeelsLikeCapsule(
                        feelsLike: weatherData.current.feelsLike(tempSetting: temperatureSetting),
                        dailyHigh: weatherData.forecastDays[0].day.maxTemperature(tempSetting: temperatureSetting),
                        dailyLow: weatherData.forecastDays[0].day.minTemperature(tempSetting: temperatureSetting)
                    )
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(weatherData.hourlyItemIndexPaths.indices, id: \.self) { i in
                                let indexPath = weatherData.hourlyItemIndexPaths[i]
                                let hour = weatherData.forecastDays[indexPath.dayIndex].hour[indexPath.hourIndex]
                                
                                HourlyForecastItem(
                                    hour: hour,
                                    isFirstCard: i == 0,
                                    isLastCard: i == weatherData.hourlyItemIndexPaths.count - 1,
                                    tempSetting: temperatureSetting
                                )
                            }
                        }
                        .padding()
                    }
                    .weatherComponentBackground()
                    
                    VStack(spacing: 15) {
                        ForEach(weatherData.forecastDays) { day in
                            DailyForecastItem(
                                forecastDay: day,
                                isFirstItem: day.id == weatherData.forecastDays[0].id,
                                tempSetting: temperatureSetting
                            )
                        }
                    }
                    .padding()
                    .weatherComponentBackground()
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        UVIndexCard(uvInfo: weatherData.current.uvInfo)
                        
                        PrecipitationCard(
                            todayPrecip: weatherData.forecastDays[0].day.totalPrecipation(measurementSetting: measurementSetting),
                            tomorrowPrecip: weatherData.forecastDays[1].day.totalPrecipation(measurementSetting: measurementSetting)
                        )
                        
                        WindCard(windInfo: weatherData.current.windInfo(measurementSetting: measurementSetting))
                        
                        HumidityCard(humidityInfo: weatherData.current.humidityInfo)
                        
                        VisibilityCard(visibilityInfo: weatherData.current.visibilityInfo(measurementSetting: measurementSetting))
                    }
                    .padding(.bottom)
                }
            }
            .scrollDisabled(isScrollDisabled)
        }
        .padding(.horizontal)
    }
}

