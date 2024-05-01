//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.05.24.
//

import Foundation
import CoreData


enum DemoData { }

extension DemoData {
	static func create(in context: NSManagedObjectContext) {
		let demoTodos = DemoTodo.todos
		
		for todo in demoTodos {
			let newTodo = StoredTodo(context: context)
			newTodo.id = UUID()
			newTodo.createdDate = todo.createdDate
			newTodo.doneDate = todo.doneDate
			newTodo.dueDate = todo.dueDate
			newTodo.isImportant = todo.isImportant
			newTodo.title = todo.title
		}
		
		try! context.save()		
	}
}


extension DemoData {
	struct DemoTodo: Codable {
		let title: String
		let isImportant: Bool
		let dueDate: Date?
		let doneDate: Date?
		let createdDate: Date
		
		static var todos: [DemoTodo] {
			do {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				return try decoder.decode([DemoTodo].self, from: Data(contentsOf: Bundle.module.url(forResource: "DemoData", withExtension: "json")!))
			} catch {
				print(error)
				return []
			}
		}
	}
}
