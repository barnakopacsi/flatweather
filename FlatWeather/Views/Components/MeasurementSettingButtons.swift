//
//  MeasurementSettingButtons.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 06..
//

import SwiftUI

struct MeasurementSettingButtons: View {
    let measurementSetting: MeasurementSetting
    let action: (MeasurementSetting) -> Void
    
    var body: some View {
        ForEach(MeasurementSetting.allCases, id: \.self) { setting in
            Button {
                action(setting)
            } label: {
                Label(
                    setting.displayName,
                    systemImage: measurementSetting == setting ? "checkmark" : setting.systemImage
                )
            }
        }
    }
}
