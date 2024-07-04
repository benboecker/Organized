//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 14.05.24.
//

import Foundation


public enum TodoListEntry: Hashable {
	case headline(date: Date, isExcluded: Bool)
	case item(id: UUID, title: String, isDone: Bool, priority: Priority)
}

public extension TodoListEntry {
	var isHeadline: Bool {
		switch self {
		case .headline: true
		case .item: false
		}
	}
	
	var title: String {
		switch self {
		case .headline(let date, _): date.formatted(.dateTime.weekday(.wide).day().month())
		case .item(_, let title, _, _): title			
		}
	}
	
	enum Priority: Comparable {
		case overdue
//		case due
		case important
		case normal
	}
}


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
