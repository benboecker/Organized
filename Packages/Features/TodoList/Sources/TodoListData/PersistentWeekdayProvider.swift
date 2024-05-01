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
	}
}


private extension PersistentWeekdayProvider {
	
	func createWeekdays(from storedTodos: [StoredTodo]) {
		var todos = storedTodos
		let calendar = Calendar.current
		var weekdays: [Weekday] = []
		var currentDate = Date.now
		var currentWeekdayTodos: [Todo] = []
		
	
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
				weekdays.append(Weekday(date: currentDate, todos: currentWeekdayTodos))
				currentWeekdayTodos.removeAll()
				
				currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? .now
			}
			
			currentWeekdayTodos.append(Todo(from: todos.removeFirst()))
		}
				
		weekdays.append(Weekday(date: currentDate, todos: currentWeekdayTodos))
		
		self.weekdays = weekdays
	}
	
}


private extension Todo {
	init(from todo: StoredTodo) {
		self.init(
			id: todo.id,
			title: todo.title,
			isDone: todo.doneDate != nil,
			isImportant: todo.isImportant
		)
	}
}
