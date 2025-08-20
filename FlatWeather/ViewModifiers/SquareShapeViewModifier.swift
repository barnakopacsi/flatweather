//
//  SquareShapeViewModifier.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 04..
//

import SwiftUI

struct SquareShapeViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .aspectRatio(1, contentMode: .fit)
    }
}

extension View {
    func squareShape() -> some View {
        modifier(SquareShapeViewModifier())
    }
}
