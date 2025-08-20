//
//  WeatherTabView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI
import SwiftUIPager

struct WeatherTabView: View {
    @Binding var selection: Int?
    
    let responses: [FormattedWeatherResponse]
    let measurementSetting: MeasurementSetting
    let tempSetting: TemperatureSetting
    
    @State private var opacity: Double = 0
    @State private var isHorizontalDragging = false
    @StateObject private var page: Page = .first()
    
    var body: some View {
        Pager(page: page, data: responses, id: \.id) { response in
            WeatherView(
                weatherData: response,
                temperatureSetting: tempSetting,
                measurementSetting: measurementSetting,
                isScrollDisabled: isHorizontalDragging
            )
            .transition(AsymmetricTransition(insertion: .scale(0.95), removal: .opacity))
        }
        .pagingPriority(.normal)
        .allowsDragging()
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    let horizontalMovement = abs(value.translation.width)
                    let verticalMovement = abs(value.translation.height)
                    
                    if horizontalMovement > verticalMovement && horizontalMovement > 10 {
                        isHorizontalDragging = true
                    }
                }
                .onEnded { _ in
                    isHorizontalDragging = false
                }
        )
        .onChange(of: page.index) { _, newIndex in
            selection = responses[newIndex].id
        }
        .opacity(opacity)
        .scaleEffect(opacity == 0 ? 0.95 : 1)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6)) {
                opacity = 1
            }
        }
        .animation(.easeInOut(duration: 0.6), value: responses.count)
    }
}
