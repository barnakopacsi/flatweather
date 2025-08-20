//
//  DeleteLocationButton.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 06..
//

import SwiftUI

struct DeleteLocationButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label("Delete Location", systemImage: "trash")
        }
    }
}
