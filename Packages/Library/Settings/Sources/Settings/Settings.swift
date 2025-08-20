//
//  NewSettings.swift
//  Settings
//
//  Created by Benjamin Böcker on 13.07.24.
//

import Foundation
import Observation
import SwiftUI
import OSLog


@Observable
public class Settings {
	private var data: SettingsData
	
	let calendar = Calendar.current
	let logger = Logger(subsystem: "Settings", category: "Settings")
	
	public init() {
		self.data = SettingsData()
		self.data = loadData()
	}
}

public extension Settings {
	var numberOfTodos: Int {
		get {
			data.numberOfTodos
		}
		set {
			data.numberOfTodos = newValue
		}
	}
	
	var didShowOnboarding: Bool {
		get {
			data.didShowOnboarding
		}
		set {
			data.didShowOnboarding = newValue
		}
	}
	
	var manuallyExcludedDates: Set<Date> {
		get {
			data.manuallyExcludedDates
		}
		set {
			data.manuallyExcludedDates = newValue
		}
	}
	
	var excludedWeekdays: Set<ExcludedWeekday> {
		get {
			data.excludedWeekdays
		}
		set {
			data.excludedWeekdays = newValue
		}
	}
}

private extension Settings {
	struct SettingsData: Sendable, Codable {
		var numberOfTodos: Int = 3
		var didShowOnboarding: Bool = false
		var manuallyExcludedDates: Set<Date> = []
		var excludedWeekdays: Set<ExcludedWeekday> = []
	}
}




// MARK: - Loading & saving data
private extension Settings {
	func saveData() {
		logger.info("saving data")
	}
	
	func loadData() -> SettingsData {
		logger.info("loaded data")
		return SettingsData()
	}
}

public extension EnvironmentValues {
	@Entry var settings = Settings()
}
