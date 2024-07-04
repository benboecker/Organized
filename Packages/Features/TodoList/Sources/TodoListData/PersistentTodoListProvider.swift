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
	public var entries: [TodoListEntry] = []
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
		let calendar = Calendar.current
		let startOfToday = calendar.startOfDay(for: .now)
		
		var todos = storedTodos
		
		var entries: [TodoListEntry] = []
		var todoCount = 0
		var currentDate = Date.now
		var maximumNumberOfTodos = 3
				
		var overDueTodos = todos.extract {
			if let dueDate = $0.dueDate, dueDate < startOfToday {
				return true
			} else {
				return false
			}
		}
		
		while todos.hasContent {
			if todoCount == 0 {
				entries.append(.headline(
					date: currentDate,
					isExcluded: ExcludedDates.contains(currentDate)
				))
				
				for todo in overDueTodos {
					entries.append(.item(
						id: todo.id,
						title: todo.title,
						isDone: todo.doneDate != nil,
						priority: .overdue
					))
					
					todoCount += 1
				}
				
				overDueTodos.removeAll()

				let dueTodos = todos.extract {
					if let dueDate = $0.dueDate {
						return calendar.isDate(currentDate, inSameDayAs: dueDate)
					} else {
						return false
					}
				}
				
				for dueTodo in dueTodos {
					entries.append(.item(
						id: dueTodo.id,
						title: dueTodo.title,
						isDone: dueTodo.doneDate != nil,
						priority: .important
					))
					todoCount += 1
				}
			}
			
			if todoCount >= maximumNumberOfTodos, let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
				currentDate = nextDate
				todoCount = 0
				maximumNumberOfTodos = 3
				continue
			}

			let todo = todos.removeFirst()
			
			entries.append(.item(
				id: todo.id,
				title: todo.title,
				isDone: todo.doneDate != nil,
				priority: todo.isImportant ? .important : .normal
			))
			
			todoCount += 1
		}
		
		self.entries = entries
	}
}
