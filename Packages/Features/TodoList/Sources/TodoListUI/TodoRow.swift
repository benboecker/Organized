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
	init(todo: Todo, focussed: FocusState<UUID?>.Binding) {
		self.todo = todo
		self._title = State(initialValue: todo.title)
		self._priority = State(initialValue: todo.priority)
		self.focussed = focussed
	}
	
	private let todo: Todo

	@State private var title: String
	@State private var priority: Todo.Priority
	@Environment(\.styleguide) private var styleguide
	@Environment(\.todoRepository) private var todoRepository

	private var focussed: FocusState<UUID?>.Binding

	var body: some View {
		HStack(alignment: .center, spacing: styleguide.large) {
			StatusView(
				isDone: isDoneBinding,
				status: status
			)
			
			TextField("", text: $title, axis: .vertical)
				.font(styleguide.body)
				.foregroundStyle(todo.isDone ? styleguide.secondaryText : styleguide.primaryText)
				.submitLabel(.return)
				.strikethrough(todo.isDone, color: .secondary)
				.disabled(todo.isDone)
				.focused(focussed, equals: todo.id)
				.ignoresSafeArea()
		}
		.onChange(of: focussed.wrappedValue) { oldValue, newValue in
			if oldValue != newValue, oldValue == todo.id, title != todo.title {
				todoRepository.update(title: title, of: todo.id)
			}
		}
	}
	
	var isDoneBinding: Binding<Bool> {
		Binding {
			todo.isDone
		} set: {
			todoRepository.update(isDone: $0, of: todo.id)
		}
	}
	
	var status: StatusView.Status {
		switch todo.priority {
		case .overdue: .urgent
		case .important: .important
		case .normal: .normal
		}
	}
}
