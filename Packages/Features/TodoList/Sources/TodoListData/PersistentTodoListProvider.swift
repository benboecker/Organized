//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import Foundation
import TodoListDomain
import Persistence
import Observation
import Utils
import SwiftUI
import Settings
import OSLog


@Observable
public class PersistentTodoListProvider: TodoListProvider {
	public init(container: PersistentContainer, settings: Settings) {
		self.settings = settings
		self.observer = StoredTodoObserver(
			context: container.mainContext
		)
	}
	
	public var sections: [TodoSection] = []

	private let settings: Settings
	private let observer: StoredTodoObserver
	private let logger = Logger(subsystem: "TodoList", category: "PersistentTodoListProvider")
	
	public func startObserving() {
		observer.didChangeObjects { [weak self] todos in
			self?.createWeekdays(from: todos)
		}
	}
	
	public func regenerate() {
		createWeekdays(from: observer.fetchedTodos)
	}
}



private extension PersistentTodoListProvider {
	
	func createWeekdays(from storedTodos: [StoredTodo]) {
		logger.info("createWeekdays from \(storedTodos.count) todos")
		
		var todos = storedTodos
		let calendar = Calendar.current
		var sections: [TodoSection] = []
		
		func getDueTodos(on date: Date) -> [Todo] {
			todos
				.extract { todo in
					if let dueDate = todo.dueDate {
						return calendar.isDate(dueDate, inSameDayAs: date) || dueDate < date
					} else {
						return false
					}
				}.map { todo in
					Todo(
						id: todo.id,
						isDone: todo.doneDate != nil,
						priority: todo.isOverdue ? .overdue : .important,
						title: todo.title
					)
				}
				.sorted { $0.isOverdue != $1.isOverdue }
		}
				
		func addTodosForDate(_ date: Date) {
			let isExcluded = settings.isDateExcluded(date)
						
			switch isExcluded {
			case .manually:
				sections.append(TodoSection(
					date: date,
					isManuallyExcluded: true,
					todos: [])
				)
			case .weekday:
				sections.append(TodoSection(
					date: date,
					isManuallyExcluded: false,
					todos: [])
				)

			case .notExcluded:
				let dueTodos = getDueTodos(on: date)
				let remainingTodoCount = settings.numberOfTodos - dueTodos.count
				
				sections.append(TodoSection(
					date: date,
					isManuallyExcluded: false,
					todos: dueTodos + todos.extract(first: remainingTodoCount).map {
						Todo(
							id: $0.id,
							isDone: $0.doneDate != nil,
							priority: $0.isImportant ? .important : .normal,
							title: $0.title
						)
					}
				))
			}
			
			if todos.hasContent, let nextDate = calendar.date(byAdding: .day, value: 1, to: date) {
				addTodosForDate(nextDate)
			}
		}
		
		addTodosForDate(.now.addingTimeInterval(100))
		
		self.sections = sections
	}
}
