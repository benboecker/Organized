//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 14.05.24.
//

import Foundation


package struct Todo: Identifiable, Hashable {
	package init(isDone: Bool, priority: Todo.Priority, title: String) {
		self.id = UUID()
		self.title = title
		self.isDone = isDone
		self.priority = priority
	}
	
	package let id: UUID
	package let title: String
	package let isDone: Bool
	package let priority: Priority
}


package extension Todo {
	enum Priority: Comparable, Hashable {
		case overdue
		case important
		case normal
	}
}


public struct TodoSection: Identifiable, Hashable {
	package init(date: Date, todos: [Todo]) {
		self.date = date
		self.todos = todos
	}
	
	package let date: Date
	package let todos: [Todo]
	
	public var id: String {
		date.formatted()
	}
}
