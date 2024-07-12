//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 26.04.24.
//

import Foundation
import NewTodoDomain
import Persistence
import Observation


@Observable
public class PersistentNewTodoCreation: NewTodoCreation {

	public init(container: PersistentContainer) {
		self.container = container
	}
	
	private let container: PersistentContainer
	
	public func createNewTodo(title: String, isImportant: Bool, dueDate: Date?) async throws {
		let context = container.createBackgroundContext()
		context.performAndWait {
			container.createObject(in: context) { (newTodo: StoredTodo) in
				newTodo.id = UUID()
				newTodo.createdDate = .now
				newTodo.isImportant = isImportant
				newTodo.title = title
				newTodo.dueDate = dueDate				
			}
			
			try? context.save()
		}
		
	}
	
}
