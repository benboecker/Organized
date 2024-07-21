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
	public var numberOfTodos: Int = 3
	public var isFocusedOnToday: Bool = false
	public var didShowOnboarding: Bool = false

	var manuallyExcludedDates: Set<Date> = []
	var excludedWeekdays: Set<ExcludedWeekday> = []
	let calendar = Calendar.current
	let logger = Logger(subsystem: "Settings", category: "Settings")
	
	public init() {
		loadData()
	}
	
	private init(numberOfTodos: Int, isFocusedOnToday: Bool, didShowOnboarding: Bool, manuallyExcludedDates: Set<Date>, excludedWeekdays: Set<Settings.ExcludedWeekday>) {
		self.numberOfTodos = numberOfTodos
		self.isFocusedOnToday = isFocusedOnToday
		self.didShowOnboarding = didShowOnboarding
		self.manuallyExcludedDates = manuallyExcludedDates
		self.excludedWeekdays = excludedWeekdays
	}
	
	public static let testing = Settings(
		numberOfTodos: 3,
		isFocusedOnToday: false,
		didShowOnboarding: true,
		manuallyExcludedDates: [],
		excludedWeekdays: []
	)
	
	public func observeChanges() {
		@Sendable func observeNumberOfTodos() {
			_ = withObservationTracking {
				numberOfTodos
			} onChange: { [weak self] in
				self?.saveData()
				observeNumberOfTodos()
			}
		}
		
		@Sendable func observeManuallyExcludedDates() {
			_ = withObservationTracking {
				manuallyExcludedDates
			} onChange: { [weak self] in
				self?.saveData()
				observeManuallyExcludedDates()
			}
		}
		
		@Sendable func observeExcludedWeekdays() {
			_ = withObservationTracking {
				excludedWeekdays
			} onChange: { [weak self] in
				self?.saveData()
				observeExcludedWeekdays()
			}
		}
		
		@Sendable func observeFocusedOnToday() {
			_ = withObservationTracking {
				isFocusedOnToday
			} onChange: { [weak self] in
				self?.saveData()
				observeFocusedOnToday()
			}
		}
		
		@Sendable func observeDidShowOnboarding() {
			_ = withObservationTracking {
				didShowOnboarding
			} onChange: { [weak self] in
				self?.saveData()
				observeDidShowOnboarding()
			}
		}
		
		observeManuallyExcludedDates()
		observeExcludedWeekdays()
		observeNumberOfTodos()
		observeFocusedOnToday()
		observeDidShowOnboarding()
	}
}




// MARK: - Loading & saving data
private extension Settings {
	
	func saveData() {
		logger.info("saving data")
	}
	
	func loadData() {
		
		logger.info("loaded data")
	}
}

public extension EnvironmentValues {
	@Entry var settings = Settings()
}
