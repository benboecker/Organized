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


@Observable
public class PersistentTodoListProvider: TodoListProvider {
	public init(persistentContainer: PersistentContainer) {
		self.observer = StoredTodoObserver(
			context: persistentContainer.mainContext
		)
		
		self.observer.didChangeObjects { [weak self] todos in
			self?.createWeekdays(from: todos)
		}
	}
	
	private let observer: StoredTodoObserver
	public var sections: [TodoSection] = []
	public func toggleDateExcluded(_ date: Date) {
		if ExcludedDates.contains(date) {
			ExcludedDates.remove(date: date)
		} else {
			ExcludedDates.add(date: date)
		}
		
		createWeekdays(from: observer.fetchedTodos)
	}
}

//package extension PersistentTodoListProvider {
//	func regenerate() {
//		createWeekdays(from: observer.fetchedTodos)
//	}
//}


private extension PersistentTodoListProvider {
	func createWeekdays(from storedTodos: [StoredTodo]) {
		let overdueTodos = storedTodos.filter(\.isOverdue)
		var todos = storedTodos.filter(\.notOverdue)
		
		let calendar = Calendar.current
		var currentDate = ExcludedDates.nextValidDate(after: nil)
		var todoCounter = 3
		var sections: [TodoSection] = []
		var currentTodos: [Todo] = overdueTodos.map {
			Todo(
				id: $0.id,
				isDone: $0.doneDate != nil,
				priority: .overdue,
				title: $0.title
			)
		}
		
		func nextDate() {
			sections.append(TodoSection(
				date: currentDate,
				isExcluded: false,
				todos: currentTodos
			))
			
			currentDate = ExcludedDates.nextValidDate(after: currentDate)
			
			currentTodos = []
			
			addDueTodos()
			
			todoCounter = 3 - currentTodos.count
		}
		
		func addDueTodos() {
			guard todos.hasContent else { return }
			let dueTodos = todos.extract { todo in
				if let dueDate = todo.dueDate {
					return calendar.isDate(dueDate, inSameDayAs: currentDate)
				} else {
					return false
				}
			}.map { todo in
				Todo(
					id: todo.id,
					isDone: todo.doneDate != nil,
					priority: .important,
					title: todo.title
				)
			}
			
			currentTodos += dueTodos
		}
		
		addDueTodos()
		todoCounter = 3 - currentTodos.count

		while todos.hasContent {
			if todoCounter <= 0 {
				nextDate()
			} else {
				let todo = todos.removeFirst()
				
				currentTodos.append(Todo(
					id: todo.id,
					isDone: todo.doneDate != nil,
					priority: todo.isImportant ? .important : .normal,
					title: todo.title
				))
								
				todoCounter -= 1
			}
		}
		
		nextDate()
		self.sections = sections
	}
}
