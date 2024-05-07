//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import Foundation
import SwiftUI
import SharedComponents
import TodoListDomain


struct TodoRow: View {
	init(todo: Todo, repository: TodoRepository) {
		self._title = State(initialValue: todo.title)
		self._isDone = State(initialValue: todo.isDone)
		self._priority = State(initialValue: todo.priority)
		self.repository = repository
		self.id = todo.id
	}
	
	@State private var title: String
	@State private var isDone: Bool
	@State private var priority: Todo.Priority
	private let repository: TodoRepository
	private let id: UUID
	
	var body: some View {
		HStack(alignment: .center, spacing: 4) {
			StatusView(isDone: $isDone, priority: $priority.wrappedValue)
			
			TextField("", text: $title, axis: .vertical)
				.fontStyle(.body)
				.color(foreground: isDone ? .secondaryText : .primaryText)
				.submitLabel(.done)
				.strikethrough(isDone, color: .secondary)
				.disabled(isDone)
		}
//		.onChange(of: isImportant) { _, newValue in
//			repository.update(isImportant: newValue, of: id)
//		}
		.onChange(of: title) { _, newValue in
			repository.update(title: newValue, of: id)
		}
		.onChange(of: isDone) { _, newValue in
			repository.update(isDone: newValue, of: id)
		}
	}
}


#Preview {
	VStack(spacing: 32) {
		TodoRow(todo: .preview, repository: PreviewRepository())
		TodoRow(todo: .previewImportant, repository: PreviewRepository())
		TodoRow(todo: .previewUrgent, repository: PreviewRepository())
		TodoRow(todo: .previewDone, repository: PreviewRepository())
	}
	.padding(8)
}


#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	) { _ in }
}
