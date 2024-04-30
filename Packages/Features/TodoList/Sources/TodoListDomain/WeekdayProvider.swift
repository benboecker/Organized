//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol WeekdayProvider {
	var weekdays: [Weekday] { get }
	func toggleDateExcluded(_ date: Date)
}
