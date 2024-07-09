//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 09.07.24.
//

import Foundation
import Observation
import SwiftUI


@Observable
public class Settings {
	public static let shared = Settings()
	
	public var numberOfTodos: Int
	public var excludedWeekdays: Set<ExcludedWeekday>
	
	public var excludedWeekdaysDescription: String {
		if excludedWeekdays.isEmpty {
			return "None"
		} else {
			return ExcludedWeekday.all
				.filter { excludedWeekdays.contains($0) }
				.map(\.short)
				.formatted(.list(type: .and))
		}
	}
	
	private init() {
		self.numberOfTodos = Self.loadNumberOfTodos()
		self.excludedWeekdays = Self.loadExcludedWeekdays()
	}
}

private extension Settings {
	func save() {
		
	}
	
	static func loadNumberOfTodos() -> Int {
		3
	}
	
	static func loadExcludedWeekdays() -> Set<ExcludedWeekday> {
		[]
	}
}

public extension Settings {
	func toggleExcluded(_ weekday: ExcludedWeekday) {
		if excludedWeekdays.contains(weekday) {
			excludedWeekdays.remove(weekday)
		} else {
			excludedWeekdays.insert(weekday)
		}
		
		save()
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


public extension EnvironmentValues {
	@Entry var settings = Settings.shared
}

