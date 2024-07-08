//
//  File.swift
//
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation
import TodoListDomain


class PreviewRepository: TodoListProvider, TodoRepository {
	
	init() {
		self.sections = .preview
	}
	
	var sections: [TodoSection] = []
	
	func toggleDateExcluded(_ date: Date) {
		
	}
	
	func update(isImportant: Bool, of todoID: UUID) {
		
	}
	
	func update(isDone: Bool, of todoID: UUID) {
		
	}
	
	func update(title: String, of todoID: UUID) {
		
	}
	
	func update(dueDate: Date?, of todoID: UUID) {
		
	}
	
	func delete(todoID: UUID) {
		
	}
}


extension Todo {
	static let previewOverdue = Todo(
		id: UUID(),
		isDone: false,
		priority: .overdue,
		title: "Wäsche waschen und trocknen"
	)
	static let previewImportant = Todo(
		id: UUID(),
		isDone: false,
		priority: .important,
		title: "Wäsche waschen und trocknen"
	)
	static let previewNormal = Todo(
		id: UUID(),
		isDone: false,
		priority: .overdue,
		title: "Wäsche waschen und trocknen"
	)
	static let previewDone = Todo(
		id: UUID(),
		isDone: true,
		priority: .normal,
		title: "Wäsche waschen und trocknen"
	)
}

extension [TodoSection] {
	static let preview: [TodoSection] = [
		TodoSection(date: .startOfToday, isExcluded: false, todos: [
			Todo(id: UUID(), isDone: false, priority: .overdue,   title: "Geburtstagsgeschenk für Mama besorgen"),
			Todo(id: UUID(), isDone: false, priority: .important, title: "Gartenarbeit - Pflanzen gießen und Unkraut jäten"),
			Todo(id: UUID(), isDone: false,  priority: .important, title: "Neue Sprache lernen - Spanisch"),
		]),
		TodoSection(date: .startOfToday.addingTimeInterval(86400 * 1), isExcluded: false, todos: [
			Todo(id: UUID(), isDone: false, priority: .important,   title: "Wäsche waschen und trocknen"),
			Todo(id: UUID(), isDone: false, priority: .important, title: "Arzttermin telefonisch vereinbaren"),
			Todo(id: UUID(), isDone: false,  priority: .normal, title: "Lebensmittel im Supermarkt einkaufen"),
		]),
		TodoSection(date: .startOfToday.addingTimeInterval(86400 * 2), isExcluded: true, todos: [
		]),
		TodoSection(date: .startOfToday.addingTimeInterval(86400 * 3), isExcluded:  false, todos: [
			Todo(id: UUID(), isDone: false, priority: .normal, title: "Reise nach Paris planen"),
			Todo(id: UUID(), isDone: true,  priority: .normal, title: "Buch über Selbstverbesserung lesen"),
			Todo(id: UUID(), isDone: false, priority: .normal,    title: "Investitionsmöglichkeiten recherchieren"),
		]),
	]
}

extension Date {
	static var startOfToday: Date { Calendar.current.startOfDay(for: .now) }
}
