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
		var currentDate = calendar.startOfDay(for: .now).addingTimeInterval(100)
		var stop = false
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
		
		func addDueTodos() {
			guard todos.hasContent else { return }
			let dueTodos = todos.extract { todo in
				if let dueDate = todo.dueDate {
					return calendar.isDate(dueDate, inSameDayAs: currentDate) || dueDate < currentDate
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
			
			
			currentTodos += dueTodos
			todoCounter = Settings.shared.numberOfTodos - currentTodos.count
		}

		func checkForStop() {
			stop = todos.isEmpty
		}
		
		repeat {
			if ExcludedDates.contains(currentDate) {
				sections.append(TodoSection(
					date: currentDate,
					isExcluded: true,
					todos: []
				))
				
				if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
					currentDate = nextDate
					checkForStop()
				} else {
					stop = true
				}
			} else {
				addDueTodos()
				
				if todoCounter > 0 {
					currentTodos += todos.extract(first: todoCounter).map {
						Todo(
							id: $0.id,
							isDone: $0.doneDate != nil,
							priority: .normal,
							title: $0.title
						)
					}
				}
				
				if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
					sections.append(TodoSection(
						date: currentDate,
						isExcluded: false,
						todos: currentTodos
					))

					currentDate = nextDate
					currentTodos = []
					checkForStop()
				} else {
					stop = true
				}
			}
		} while !stop
		
		self.sections = sections
	}
}
