//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.04.24.
//

import Foundation
import OSLog
import SwiftUI
import Observation


@Observable
public class ExcludedDates {
	
	public static let shared = ExcludedDates()
	
	private var manuallyExcludedDates: Set<Date> = []
	private var excludedWeekdays: Set<ExcludedWeekday> = []
	private let calendar = Calendar.current
	private let logger = Logger(subsystem: "Settings", category: "ExcludedDates")
	
	private init() {
		loadDates()
		cleanUp()
	}
}


public extension ExcludedDates {
	enum ExcludedState: Equatable {
		case manually, weekday, notExcluded
	}
	
	func isDateExcluded(_ date: Date) -> ExcludedState {
		if isManuallyExcluded(date) {
			return .manually
		} else if isWeekdayExcluded(date) {
			return .weekday
		} else {
			return .notExcluded
		}
	}
	
	func isWeekdayExcluded(_ weekday: ExcludedWeekday) -> Bool {
		return excludedWeekdays.contains { $0 == weekday }
	}

	func nextDate(after _date: Date) -> (date: Date, isExcluded: ExcludedState) {
		let date: Date
		
		if let possibleDate = Calendar.current.date(byAdding: .day, value: 1, to: _date) {
			date = possibleDate
		} else {
			date = Calendar.current.startOfDay(for: .now).addingTimeInterval(10)
		}
		
		return (date: date, isExcluded: isDateExcluded(date))
	}
	
	func toggleManuallyExclude(date: Date) {
		let index = manuallyExcludedDates.firstIndex {
			calendar.isDate($0, inSameDayAs: date)
		}
		
		if let index {
			manuallyExcludedDates.remove(at: index)
			logger.info("included date \(date)")
		} else {
			manuallyExcludedDates.insert(date)
			logger.info("excluded date \(date)")
		}
		
		saveDates()
	}
	
	func toggleWeekdayExcluded(_ weekday: ExcludedWeekday) {
		if excludedWeekdays.contains(weekday) {
			excludedWeekdays.remove(weekday)
		} else {
			excludedWeekdays.insert(weekday)
		}
	}
	
	var excludedWeekdaysDescription: String {
		if excludedWeekdays.isEmpty {
			return "None"
		} else {
			return ExcludedWeekday.all
				.filter { excludedWeekdays.contains($0) }
				.map(\.short)
				.formatted(.list(type: .and))
		}
	}
	
	/// used for unit tests
	func removeAll() {
		manuallyExcludedDates.removeAll()
		saveDates()
	}
	
	struct ExcludedWeekday: Hashable {
		public let name: String
		public let short: String
		public let index: Int
		
		public static var all: [ExcludedWeekday] {
			let calendar = Calendar.current
			let weekdayNamesShort = calendar.localizedWeekdaysShort
			
			return calendar.localizedWeekdays.enumerated().map { index, name in
				ExcludedWeekday(
					name: name,
					short: weekdayNamesShort[index],
					index: index
				)
			}
		}
	}
}


private extension ExcludedDates {
	var key: String { "de.ben-boecker.organized.manually-excluded-dates" }
	
	func loadDates() {
		if let dates = UserDefaults.standard.object(forKey: key) as? [Date] {
			self.manuallyExcludedDates = Set(dates)
		}
	}
	
	func saveDates() {
		UserDefaults.standard.setValue(Array(manuallyExcludedDates), forKey: key)
	}
	
	func cleanUp() {
		let start = calendar.startOfDay(for: .now)
		
		let pastDates = manuallyExcludedDates.filter { $0 < start }
		for pastDate in pastDates {
			manuallyExcludedDates.remove(pastDate)
		}
		
		saveDates()
	}
	
	func isManuallyExcluded(_ date: Date) -> Bool {
		return manuallyExcludedDates.contains { excludedDate in
			calendar.isDate(excludedDate, inSameDayAs: date)
		}
	}

	func isWeekdayExcluded(_ date: Date) -> Bool {
		let index = calendar.component(.weekday, from: date)
		
		return excludedWeekdays.contains { $0.index == index }
	}
}
