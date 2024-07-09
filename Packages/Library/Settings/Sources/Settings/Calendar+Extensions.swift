//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 09.07.24.
//

import Foundation


public extension Calendar {
	
	var localizedWeekdays: [String] {
		if firstWeekday > 1 {
			let firstWeekdays = Array(weekdaySymbols.prefix(firstWeekday - 1))
			let remainingWeekdays = Array(weekdaySymbols.dropFirst(firstWeekday - 1))
			return remainingWeekdays + firstWeekdays
		} else {
			return weekdaySymbols
		}
	}
	
	
	var localizedWeekdaysShort: [String] {
		if firstWeekday > 1 {
			let firstWeekdays = Array(shortWeekdaySymbols.prefix(firstWeekday - 1))
			let remainingWeekdays = Array(shortWeekdaySymbols.dropFirst(firstWeekday - 1))
			return remainingWeekdays + firstWeekdays
		} else {
			return shortWeekdaySymbols
		}
	}
	
	
	
}
