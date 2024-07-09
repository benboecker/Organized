//
//  SettingsTests.swift
//  
//
//  Created by Benjamin Böcker on 09.07.24.
//

import XCTest
import Settings


final class SettingsTests: XCTestCase {
	
	func testExcludeWeekdays() {
		let wee = Calendar.current.standaloneWeekdaySymbols
		let e = Settings.shared.excludedWeekdaysDescription
		
		print(wee)
		
	}
}
