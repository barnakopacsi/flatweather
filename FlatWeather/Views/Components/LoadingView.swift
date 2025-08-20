//
//  LoadingView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 05..
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ContentUnavailableView {
            ProgressView()
        }
    }
}

#Preview {
    LoadingView()
}
