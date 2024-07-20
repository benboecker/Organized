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
	public var showOnboarding: Bool = true

	var manuallyExcludedDates: Set<Date> = []
	var excludedWeekdays: Set<ExcludedWeekday> = []
	let calendar = Calendar.current
	let logger = Logger(subsystem: "Settings", category: "Settings")
	
	public init() {
		loadData()
	}
	
	private init(numberOfTodos: Int, isFocusedOnToday: Bool, showOnboarding: Bool, manuallyExcludedDates: Set<Date>, excludedWeekdays: Set<Settings.ExcludedWeekday>) {
		self.numberOfTodos = numberOfTodos
		self.isFocusedOnToday = isFocusedOnToday
		self.showOnboarding = showOnboarding
		self.manuallyExcludedDates = manuallyExcludedDates
		self.excludedWeekdays = excludedWeekdays
	}
	
	public static let testing = Settings(
		numberOfTodos: 3,
		isFocusedOnToday: false,
		showOnboarding: false,
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
		
		@Sendable func observeShowOnboarding() {
			_ = withObservationTracking {
				showOnboarding
			} onChange: { [weak self] in
				self?.saveData()
				observeShowOnboarding()
			}
		}
		
		observeManuallyExcludedDates()
		observeExcludedWeekdays()
		observeNumberOfTodos()
		observeFocusedOnToday()
		observeShowOnboarding()
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
