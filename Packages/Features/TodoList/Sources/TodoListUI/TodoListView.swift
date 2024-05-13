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
	
	@Environment(\.styleguide) private var styleguide
	
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
								.font(styleguide[\.title])
						} description: {
							Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
								.font(styleguide[\.body])		
								.padding(.horizontal)
								.padding(.top, 8)
						}
					} else {
						ForEach(weekday.todos) { todo in
							TodoRow(
								todo: todo,
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
			.animation(.snappy, value: weekdayProvider.weekdays)
		}
	}
	
	@ViewBuilder
	func TodoContextMenu(for todo: Todo) -> some View {
		if todo.isDone {
			EmptyView()
		} else {
			if todo.priority == .normal {
				Button {
					todoRepository.update(isImportant: true, of: todo.id)
				} label: {
					Label("Wichtig", systemImage: "exclamationmark.circle")
				}
			} else if todo.priority == .important {
				Button {
					todoRepository.update(isImportant: false, of: todo.id)
				} label: {
					Label("Nicht wichtig", systemImage: "circle")
				}
			}
			
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
