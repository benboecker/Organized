//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation



public struct Todo: Decodable, Identifiable, Hashable {
	package init(id: UUID, title: String, isDone: Bool, dueDate: Date?, isImportant: Bool) {
		self.id = id
		self.title = title
		self.isDone = isDone
		self.isImportant = isImportant
		self.dueDate = dueDate
	}
	
	public let id: UUID
	package let title: String
	package let isDone: Bool
	package let dueDate: Date?
	package let isImportant: Bool
}
