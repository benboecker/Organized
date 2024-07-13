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
	
	var manuallyExcludedDates: Set<Date> = []
	var isFocusedOnToday: Bool = true
	var excludedWeekdays: Set<ExcludedWeekday> = []
	let calendar = Calendar.current
	let logger = Logger(subsystem: "Settings", category: "Settings")
	
	public init() {
		loadData()
	}
	
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
		
		observeManuallyExcludedDates()
		observeExcludedWeekdays()
		observeNumberOfTodos()
		observeFocusedOnToday()
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
