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
	

}


private extension Weekday {
	static var preview: Weekday {
		[Weekday].preview.first!
	}

}

private extension [Weekday] {
	static var preview: [Weekday] {
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			return try decoder.decode([Weekday].self, from: Data(contentsOf: Bundle.module.url(forResource: "weekdays", withExtension: "json")!))
		} catch {
			print(error)
			return []
		}
	}

}

private extension Todo {
	static var preview: Todo {
		[Todo].preview.first!
	}

}

private extension [Todo] {
	static var preview: [Todo] {
		Weekday.preview.todos
	}
}
