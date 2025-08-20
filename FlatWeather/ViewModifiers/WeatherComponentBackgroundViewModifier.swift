//
//  WeatherComponentBackgroundViewModifier.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI

struct WeatherComponentBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

extension View {
    func weatherComponentBackground() -> some View {
        modifier(WeatherComponentBackgroundViewModifier())
    }
}
