//
//  AddLocationButton.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 06..
//

import SwiftUI

struct AddLocationButton: View {
    @Environment(\.colorScheme) var colorScheme
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
        }
        .foregroundStyle(colorScheme == .light ? .black : .white)
        .fontWeight(.medium)
    }
}
