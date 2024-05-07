//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol TodoRepository {
	func update(isImportant: Bool, of todoID: Todo.ID)
	func update(isDone: Bool, of todoID: Todo.ID)
	func update(title: String, of todoID: Todo.ID)
	func update(dueDate: Date?, of todoID: Todo.ID)
	
	func delete(todoID: UUID)
	
}
