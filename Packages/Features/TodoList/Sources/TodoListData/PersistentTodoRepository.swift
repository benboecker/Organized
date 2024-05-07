//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import Foundation
import TodoListDomain
import Persistence
import CoreData


public class PersistentTodoRepository: TodoRepository {
	
	public init(container: PersistentContainer) {
		self.container = container
	}
	
	private let container: PersistentContainer

	public func update(isImportant: Bool, of todoID: TodoListDomain.Todo.ID) {
		update(\.isImportant, value: isImportant, on: todoID)
	}
	
	public func update(isDone: Bool, of todoID: TodoListDomain.Todo.ID) {
		if isDone {
			update(\.dueDate, value: .now, on: todoID)
		} else {
			update(\.dueDate, value: nil, on: todoID)
		}
	}
	
	public func update(title: String, of todoID: TodoListDomain.Todo.ID) {
		update(\.title, value: title, on: todoID)
	}
	
	public func update(dueDate: Date?, of todoID: TodoListDomain.Todo.ID) {
		update(\.dueDate, value: dueDate, on: todoID)
	}
	
	public func delete(todoID: UUID) {
		let context = container.createBackgroundContext()
		context.performAndWait {
			container.deleteObject(objectType: StoredTodo.self, with: todoID, in: context)
			
			try? context.save()
		}
	}
	
}

private extension PersistentTodoRepository {
	
	func update<Value>(_ keypath: WritableKeyPath<StoredTodo, Value>, value: Value, on todoID: UUID) {
		let context = container.createBackgroundContext()
		context.performAndWait {
			guard var todo: StoredTodo = container.getObject(with: todoID, in: context) else {
				return
			}
			
			todo[keyPath: keypath] = value
			try? context.save()
		}

	}
	
}
