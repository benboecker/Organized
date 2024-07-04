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
import Styleguide


struct TodoRow: View {
	init(id: UUID, title: String, isDone: Bool, priority: Todo.Priority, repository: TodoRepository, focussed: FocusState<UUID?>.Binding) {
		self.originalTitle = title
		self._title = State(initialValue: title)
		self.isDone = isDone
		self._priority = State(initialValue: priority)
		self.repository = repository
		self.id = id
		self.focussed = focussed
	}
	
	private let originalTitle: String
	@State private var title: String
	private var isDone: Bool
	@State private var priority: Todo.Priority
	@Environment(\.styleguide) private var styleguide
	private let repository: TodoRepository
	private let id: UUID
	private var focussed: FocusState<UUID?>.Binding

	
	var body: some View {
		HStack(alignment: .center, spacing: styleguide.large) {
			StatusView(isDone: Binding(get: {
				isDone
			}, set: {
				repository.update(isDone: $0, of: id)
			}), priority: $priority.wrappedValue)
			
			TextField("", text: $title, axis: .vertical)
				.font(styleguide.body)
				.foregroundStyle(isDone ? styleguide.secondaryText : styleguide.primaryText)
				.submitLabel(.return)
				.strikethrough(isDone, color: .secondary)
				.disabled(isDone)
				.focused(focussed, equals: id)
				.ignoresSafeArea()
		}
		.onChange(of: focussed.wrappedValue) { oldValue, newValue in
			if oldValue != newValue, oldValue == id, title != originalTitle {
				repository.update(title: title, of: id)
			}			
		}
	}
}


#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	) { _ in }
		.styledPreview()
}
