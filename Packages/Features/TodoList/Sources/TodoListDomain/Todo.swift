//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation



public struct Todo: Decodable, Identifiable, Hashable {
	package init(id: UUID, title: String, isDone: Bool, dueDate: Date?, priority: Priority) {
		self.id = id
		self.title = title
		self.isDone = isDone
		self.priority = priority
		self.dueDate = dueDate
	}
	
	public let id: UUID
	package let title: String
	package let isDone: Bool
	package let dueDate: Date?
	package let priority: Priority
}


public extension Todo {
	enum Priority: Int, Decodable, Comparable {
		public static func < (lhs: Todo.Priority, rhs: Todo.Priority) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
		
		case normal = 0, important, urgent
	}
}
