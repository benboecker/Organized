//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 25.06.24.
//

import SwiftUI



struct ListView: View {
	struct Todo: Identifiable {
		let id: UUID
		var text: String
	}
	
	@State private var todos: [Todo] = [
		Todo(id: UUID(), text: "Buy groceries for dinner"),
		Todo(id: UUID(), text: "Schedule dentist appointment online"),
		Todo(id: UUID(), text: "Finish report for work"),
		Todo(id: UUID(), text: "Call mom about weekend plans"),
		Todo(id: UUID(), text: "Clean kitchen and bathroom"),
	]
		
	@FocusState var focus: UUID?
	
    var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack(spacing: 8) {
					ForEach($todos) { todo in
						TextField("d", text: todo.text, axis: .vertical)
							.focused($focus, equals: todo.id)
							.padding(.horizontal, 16)
							.padding(.vertical, 8)
							.background(.quinary, in: .rect(cornerRadius: 8))
							.onSubmit {
								nextFocus(after: focus)
							}
							.overlay(alignment: .bottomLeading) {
								Text(todo.id.uuidString)
									.font(.system(.caption2))
									.offset(y: 2)
							}
					}
				}
				.padding()
			}
			.navigationTitle("Aufgaben")
			.overlay(alignment: .bottom) {
				Text(focus?.uuidString ?? "---")
					.font(.system(.body, weight: .heavy))
					.foregroundStyle(.white)
					.padding(.vertical, 6)
					.padding(.horizontal, 16)
					.background(.primary.opacity(0.5), in: .capsule)
			}
		}
    }
	
	func nextFocus(after previous: UUID?) {
		let todoIndex = todos.firstIndex { previous == $0.id }
		
		if let todoIndex, todoIndex < todos.endIndex - 1 {
			let nextIndex = todos.index(after: todoIndex)
			focus = todos[nextIndex].id
		}
	}
}

#Preview {
	ListView()
}
