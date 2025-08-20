//
//  AppearanceSettingButtons.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 06..
//

import SwiftUI

struct AppearanceSettingButtons: View {
    let appearanceSetting: AppearanceSetting
    let action: (AppearanceSetting) -> Void
    
    var body: some View {
        ForEach(AppearanceSetting.allCases, id: \.self) { setting in
            Button {
                action(setting)
            } label: {
                Label(
                    setting.displayName,
                    systemImage: appearanceSetting == setting ? "checkmark" : setting.systemImage
                )
            }
        }
    }
}

