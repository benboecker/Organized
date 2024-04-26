//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import Foundation
import TodoListDomain


public class PersistentWeekdayProvider: WeekdayProvider {
	
	public init() {
		self.weekdays = []
	}
	
	public var weekdays: [TodoListDomain.Weekday]

	
}
