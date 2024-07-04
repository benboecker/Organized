//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 23.04.24.
//

import SwiftUI
import TodoListDomain
import Utils
import Styleguide
import SharedComponents


public struct TodoListView: View {
	public init(
		todoRepository: TodoRepository,
		weekdayProvider: TodoListProvider,
		showNewTodo: @escaping (Date) -> Void
	) {
		self.weekdayProvider = weekdayProvider
		self.todoRepository = todoRepository
		self.showNewTodo = showNewTodo
	}
	
	private let todoRepository: TodoRepository
	private let weekdayProvider: TodoListProvider
	private let showNewTodo: (Date) -> Void
	
	@Environment(\.styleguide) private var styleguide
	@FocusState private var focussedTodoID: UUID?
	
	public var body: some View {
		ScrollView {
			LazyVStack(spacing: styleguide.large) {
				ForEach(weekdayProvider.sections) { section in
					Section {
						if section.todos.isEmpty {
							ContentUnavailableView {
								Label(section.date.formatted(.dateTime.weekday().day().month()), systemImage: "beach.umbrella")
									.font(styleguide.title)
							} description: {
								Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
									.font(styleguide.body)
									.padding(.horizontal)
							}
							.padding(.top, styleguide.medium)
							.padding(.bottom, -styleguide.large)
						} else {
							ForEach(section.todos) { todo in
								TodoRow(
									id: todo.id,
									title: todo.title,
									isDone: todo.isDone,
									priority: todo.priority,
									repository: todoRepository,
									focussed: $focussedTodoID
								)
							}
						}
					} header: {
						if section.todos.hasContent {
							WeekdayHeaderView(date: section.date, weekdayProvider: weekdayProvider, isExcluded: section.todos.isEmpty) { date in
								showNewTodo(date)
							}
							.padding(.top, styleguide.extraLarge)
							.padding(.leading, 42)
						}
					}
				}
			}		
//			.toolbar {
//				ToolbarItems()
//			}
			.animation(.snappy, value: weekdayProvider.entries)
			.padding(.horizontal, styleguide.large)
			.padding(.leading, styleguide.extraSmall)
			.padding(.bottom, styleguide.extraLarge)
		}
	}
	
	@ViewBuilder
	func TodoContextMenu(id: UUID, priority: TodoListEntry.Priority) -> some View {
		if priority == .normal {
			Button {
				todoRepository.update(isImportant: true, of: id)
			} label: {
				Label("Wichtig", systemImage: "exclamationmark.circle")
			}
		} else if priority == .important {
			Button {
				todoRepository.update(isImportant: false, of: id)
			} label: {
				Label("Nicht wichtig", systemImage: "circle")
			}
		}
		
		Button {
			
		} label: {
			Label("Fällig am", systemImage: "calendar")
		}
		
		Divider()
		
		Button(role: .destructive) {
			
		} label: {
			Label("Löschen", systemImage: "trash")
		}
	}
	
	func ToolbarItems() -> some ToolbarContent {
		ToolbarItemGroup(placement: .keyboard) {
			Button {
				if let focussedTodoID {
					self.focussedTodoID = weekdayProvider.id(before: focussedTodoID)
				}
			} label: {
				Label("Zurück", systemImage: "arrow.up")
			}
			.tint(styleguide.primaryText)
			
			Color.clear.frame(width: 10)
			
			Button {
				if let focussedTodoID {
					self.focussedTodoID = weekdayProvider.id(after: focussedTodoID)
				}
			} label: {
				Label("Weiter", systemImage: "arrow.down")
					.padding(.leading, 10)
			}
			.tint(styleguide.primaryText)

			Spacer()
			
			Button {
				UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
			} label: {
				Label("Fertig", systemImage: "keyboard.chevron.compact.down")
			}
			.tint(styleguide.primaryText)
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
