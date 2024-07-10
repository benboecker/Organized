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
	
	public var numberOfTodos: Int = 3
	
	private init() {
		loadData()
	}
}

public extension Settings {
	func setNumberOfTodos(_ numberOfTodos: Int) {
		self.numberOfTodos = numberOfTodos
		saveData()
	}
}

private extension Settings {
	var numberOfTodosKey: String { "de.ben-boecker.organized.number-of-todos" }

	func loadData() {
		if let numberOfTodos = UserDefaults.standard.object(forKey: numberOfTodosKey) as? Int {
			self.numberOfTodos = numberOfTodos
		}
	}
	
	func saveData() {
		UserDefaults.standard.setValue(numberOfTodos, forKey: numberOfTodosKey)
	}
}


public extension EnvironmentValues {
	@Entry var settings = Settings.shared
}

