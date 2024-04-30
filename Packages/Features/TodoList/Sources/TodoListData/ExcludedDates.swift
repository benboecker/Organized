//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.04.24.
//

import Foundation
import OSLog


class ExcludedDates {
	
	static let shared = ExcludedDates()
	
	private var dates: [Date] = []
	private let calendar = Calendar.current
	
	private init() {
		loadDates()
		cleanUp()
	}
}


extension ExcludedDates {
	
	static func contains(_ date: Date) -> Bool {
		let excluded = ExcludedDates.shared
		return excluded.dates.contains { excludedDate in
			excluded.calendar.isDate(excludedDate, inSameDayAs: date)
		}
	}
	
	static func add(date: Date) {
		guard contains(date) == false else { return }
		let excluded = ExcludedDates.shared
		
		excluded.dates.append(date)
		excluded.saveDates()
	}
	
	static func remove(date: Date) {
		guard contains(date) else { return }
		let excluded = ExcludedDates.shared
		
		excluded.dates.removeAll { excluded.calendar.isDate($0, inSameDayAs: date) }
		excluded.saveDates()
	}
	
}


private extension ExcludedDates {
	var key: String { "de.ben-boecker.organized.excluded-dates" }
	
	func loadDates() {
		if let dates = UserDefaults.standard.object(forKey: key) as? [Date] {
			self.dates = dates
		}
	}
	
	func saveDates() {
		UserDefaults.standard.setValue(dates, forKey: key)
	}
	
	func cleanUp() {
		let start = calendar.startOfDay(for: .now)
		
		dates.removeAll { $0 < start }
		
		saveDates()
	}
}
