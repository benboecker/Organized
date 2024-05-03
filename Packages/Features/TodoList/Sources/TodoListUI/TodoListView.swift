//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import SwiftUI
import TodoListDomain
import Utils


public struct TodoListView: View {
	public init(
		todoRepository: TodoRepository,
		weekdayProvider: WeekdayProvider,
		showNewTodo: @escaping (Date) -> Void
	) {
		self.weekdayProvider = weekdayProvider
		self.todoRepository = todoRepository
		self.showNewTodo = showNewTodo
	}
	
	private let todoRepository: TodoRepository
	private let weekdayProvider: WeekdayProvider
	private let showNewTodo: (Date) -> Void
	
	public var body: some View {
		ScrollView {
			LazyVStack(spacing: 8) {
				ForEach(weekdayProvider.weekdays, id: \.self) { weekday in
					WeekdayHeaderView(
						date: weekday.date,
						weekdayProvider: weekdayProvider,
						isExcluded: weekday.todos.isEmpty
					) { date in
						showNewTodo(date)
					}
					.padding(.horizontal, 58)
					.padding(.top, 24)
					.padding(.bottom, 12)
					.offset(y: 8)

					if weekday.todos.isEmpty {
						ContentUnavailableView {
							Label("Keine Aufgaben", systemImage: "beach.umbrella")
								.fontStyle(.title)
						} description: {
							Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
								.fontStyle(.body)
								.padding(.horizontal)
								.padding(.top, 8)
						}
						.padding(.top)
					} else {
						ForEach(weekday.todos) { todo in
							TodoRow(
								title: todo.title,
								isDone: todo.isDone,
								isImportant: todo.isImportant,
								repository: todoRepository
							)
							.padding(.horizontal, 12)
							.contextMenu {
								TodoContextMenu(for: todo)
							}
						}
					}
				}
			}
		}
	}
	
	@ViewBuilder
	func TodoContextMenu(for todo: Todo) -> some View {
		if todo.isDone {
			EmptyView()
		} else {
			Button {
				
			} label: {
				Label(todo.dueDate == nil ? "Set due date" : "Change due date", systemImage: "calendar")
			}
			Divider()
			Button(role: .destructive) {
				
			} label: {
				Label("Löschen", systemImage: "trash")
			}
		}
	}
}

#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	) { _ in }
}
