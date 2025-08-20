//
//  StringExtension.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 15..
//
//  Provides convenience formatting for date and time strings.
//

import Foundation

extension String {
    func formattedDay(isToday: Bool = false) -> String {
        guard !isToday else { return NSLocalizedString("Today", comment: "") }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else { return self }
        
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }

    func formattedTime(isNow: Bool = false, locale: Locale = .current) -> String {
        guard !isNow else { return NSLocalizedString("Now", comment: "") }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: self) else { return self }
        
        // Use 12-hour or 24-hour format depending on locale
        let template = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale) ?? "Hm"
        formatter.setLocalizedDateFormatFromTemplate(template.contains("a") ? "ha" : "Hm")
        formatter.locale = locale
        
        return formatter.string(from: date)
    }
}
