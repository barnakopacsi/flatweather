//
//  TemperatureSettingButtons.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 06..
//

import SwiftUI

struct TemperatureSettingButtons: View {
    let temperatureSetting: TemperatureSetting
    let action: (TemperatureSetting) -> Void
    
    var body: some View {
        ForEach(TemperatureSetting.allCases, id: \.self) { setting in
            Button {
                action(setting)
            } label: {
                Label(
                    setting.displayName,
                    systemImage: temperatureSetting == setting ? "checkmark" : setting.systemImage
                )
            }
        }
    }
}
