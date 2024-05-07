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


@Observable
public class PersistentWeekdayProvider: WeekdayProvider {
	
	public init(persistentContainer: PersistentContainer) {
		self.weekdays = []
		self.observer = StoredTodoObserver(
			context: persistentContainer.mainContext
		)
		
		self.observer.didChangeObjects { [weak self] todos in
			self?.createWeekdays(from: todos)
		}
	}
	
	private let observer: StoredTodoObserver
	public var weekdays: [TodoListDomain.Weekday]
		
	public func toggleDateExcluded(_ date: Date) {
		if ExcludedDates.contains(date) {
			ExcludedDates.remove(date: date)
		} else {
			ExcludedDates.add(date: date)
		}
		
		createWeekdays(from: observer.fetchedTodos)
	}
}

//package extension PersistentWeekdayProvider {
//	func regenerate() {
//		createWeekdays(from: observer.fetchedTodos)
//	}
//}

private extension PersistentWeekdayProvider {
	func createWeekdays(from storedTodos: [StoredTodo]) {
		var todos = storedTodos
		let calendar = Calendar.current
		var weekdays: [Weekday] = []
		var currentWeekdayTodos: [Todo] = []
		var currentDate = nextWeekday(after: nil)
		
		func nextWeekday(after date: Date?) -> Date {
			let nextDate: Date
			
			if let date {
				weekdays.append(Weekday(date: date, todos: currentWeekdayTodos.sorted { $0.priority < $1.priority }.reversed()))
				currentWeekdayTodos.removeAll()
				
				nextDate = calendar.date(byAdding: .day, value: 1, to: date) ?? date
			} else {
				nextDate = Date.now
			}
			
			if ExcludedDates.contains(nextDate) {
				return nextWeekday(after: nextDate)
			} else {
				return nextDate
			}
		}

		while !todos.isEmpty {
			let dueTodos = todos.filter {
				if let dueDate = $0.dueDate {
					return calendar.isDate(dueDate, inSameDayAs: currentDate)
				} else {
					return false
				}
			}
			
			currentWeekdayTodos.append(contentsOf: dueTodos.map(Todo.init))
			
			todos.removeAll { dueTodos.contains($0) }
			
			if currentWeekdayTodos.count >= 3 {
				currentDate = nextWeekday(after: currentDate)
			}
			
			currentWeekdayTodos.append(Todo(from: todos.removeFirst()))
		}
				
		weekdays.append(Weekday(date: currentDate, todos: currentWeekdayTodos.sorted { $0.priority < $1.priority }.reversed()))
		
		self.weekdays = weekdays
	}
}


private extension Todo {
	init(from todo: StoredTodo) {
		self.init(
			id: todo.id,
			title: todo.title,
			isDone: todo.doneDate != nil,
			dueDate: todo.dueDate,
			priority: .normal
		)
	}
}
