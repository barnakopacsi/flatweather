//
//  NoInternetView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No internet connection", systemImage: "wifi.slash")
        } description: {
            Text("Weather data will be available automatically when the iPhone is connected to the internet.")
        }
    }
}

#Preview {
    NoInternetView()
}
