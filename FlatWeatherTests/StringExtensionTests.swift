//
//  StringExtensionTests.swift
//  FlatWeatherTests
//
//  Created by Barna Kopácsi on 2025. 08. 14..
//

import XCTest
@testable import FlatWeather

final class StringExtensionTests: XCTestCase {
    func testFormattedDay_withValidDate_returnsCorrectDay() {
        let dateString = "2025-07-15"
        
        let result = dateString.formattedDay()
        
        XCTAssertEqual(result, "Tue")
    }
    
    func testFormattedDay_withValidDate_returnsToday() {
        let dateString = "2025-07-15"
        
        let result = dateString.formattedDay(isToday: true)
        
        XCTAssertEqual(result, "Today")
    }
    
    func testFormattedDay_withLeapYear_returnsCorrectDay() {
        let dateString = "2024-02-29"
        
        let result = dateString.formattedDay()
        
        XCTAssertEqual(result, "Thu")
    }
    
    func testFormattedDay_withInvalidDate_returnsOriginalString() {
        let dateString = "Invalid Date String"
        
        let result = dateString.formattedDay()
        
        XCTAssertEqual(result, dateString)
    }
    
    func testFormattedTime_withValidDate_24HourLocale_returns24HourFormat() {
        let dateString = "2025-02-18 15:00"
        let hungarianLocale = Locale(identifier: "hu_HU")
        
        
        let result = dateString.formattedTime(locale: hungarianLocale)
        
        XCTAssertEqual(result, "15:00")
    }
    
    func testFormattedTime_withValidDate_12HourLocale_returns12HourFormat() {
        let dateString = "2025-02-18 15:00"
        let usLocale = Locale(identifier: "en_US")
        
        
        let result = dateString.formattedTime(locale: usLocale)
        
        XCTAssertTrue(result.contains("3"), "Should contain hour '3' for 3 PM")
        XCTAssertTrue(result.uppercased().contains("PM"), "Should contain 'PM' for afternoon time")
        XCTAssertFalse(result.contains("15"), "Should not contain '15' in 12-hour format")
        XCTAssertEqual(result.count, 4, "Should be 4 characters long (like '3 PM')")
    }
    
    func testFormattedTime_withValidDate_returnsNow() {
        let dateString = "2025-09-10 11:00"
        
        let result = dateString.formattedTime(isNow: true)
        
        XCTAssertEqual(result, "Now")
    }
    
    func testFormattedTime_withInvalidDate_returnsOriginalString() {
        let dateString = "Invalid Date String"
        
        let result = dateString.formattedTime()
        
        XCTAssertEqual(result, dateString)
    }
}
