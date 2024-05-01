//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation



public struct Todo: Decodable, Identifiable, Hashable {
	package init(id: UUID, title: String, isDone: Bool, isImportant: Bool) {
		self.id = id
		self.title = title
		self.isDone = isDone
		self.isImportant = isImportant
	}
	
	public let id: UUID
	package let title: String
	package let isDone: Bool
	package let isImportant: Bool
}
