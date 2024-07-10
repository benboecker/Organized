//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol TodoListProvider {
	var sections: [TodoSection] { get }
}


package extension TodoListProvider {
	func id(after id: UUID) -> UUID? {
		let flattenedTodoIDs = flattenedTodos.map(\.id)
		let index = flattenedTodoIDs.firstIndex(of: id)
		
		if let index, index < flattenedTodoIDs.endIndex - 1 {
			return flattenedTodoIDs[flattenedTodoIDs.index(after: index)]
		} else {
			return nil
		}
	}
	
	func id(before id: UUID) -> UUID? {
		let flattenedTodoIDs = flattenedTodos.map(\.id)
		let index = flattenedTodoIDs.firstIndex(of: id)
		
		if let index, index > flattenedTodoIDs.startIndex {
			return flattenedTodoIDs[flattenedTodoIDs.index(before: index)]
		} else {
			return nil
		}
	}
	
	var flattenedTodos: [Todo] {
		sections.reduce([]) { $0 + $1.todos }
	}
}
