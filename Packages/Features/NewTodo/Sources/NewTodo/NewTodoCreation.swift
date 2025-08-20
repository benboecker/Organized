//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 26.04.24.
//

import Foundation


public protocol NewTodoCreation {
	@MainActor
	func createNewTodo(
		title: String,
		isImportant: Bool,
		dueDate: Date?
	) async throws
	
}
