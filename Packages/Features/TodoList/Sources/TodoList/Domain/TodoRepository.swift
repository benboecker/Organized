//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol TodoRepository {
	func update(isImportant: Bool, of todoID: UUID)
	func update(isDone: Bool, of todoID: UUID)
	func update(title: String, of todoID: UUID)
	func update(dueDate: Date?, of todoID: UUID)
	
	func delete(todoID: UUID)
	
}
