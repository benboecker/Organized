//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation
import TodoListDomain


class PreviewRepository: WeekdayProvider, TodoRepository {
	
	
	init() {
		self.weekdays = .preview
	}

	var weekdays: [TodoListDomain.Weekday]
	
	func toggleDateExcluded(_ date: Date) {
		
	}
	
	func update(isImportant: Bool, of todoID: TodoListDomain.Todo.ID) {
		
	}
	
	func update(isDone: Bool, of todoID: TodoListDomain.Todo.ID) {
		
	}
	
	func update(title: String, of todoID: TodoListDomain.Todo.ID) {
		
	}
	
	func update(dueDate: Date?, of todoID: TodoListDomain.Todo.ID) {
		
	}
	
	func delete(todoID: UUID) {
		
	}
}


extension Weekday {
	static var preview: Weekday {
		[Weekday].preview.first!
	}

}

extension [Weekday] {
	static var preview: [Weekday] {
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			return try decoder.decode([Weekday].self, from: Data(contentsOf: Bundle.module.url(forResource: "weekdays", withExtension: "json")!))
		} catch {
			print("\(error)")
			return []
		}
	}

}

extension Todo {
	static var preview: Todo {
		[Todo].preview[3]
	}
	
	static var previewImportant: Todo {
		[Todo].preview[2]
	}
	
	static var previewUrgent: Todo {
		[Todo].preview[0]
	}
	
	static var previewDone: Todo {
		[Todo].preview[1]
	}
	
}

extension [Todo] {
	static var preview: [Todo] {
		Weekday.preview.todos
	}
}
