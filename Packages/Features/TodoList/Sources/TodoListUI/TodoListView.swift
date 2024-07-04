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
			LazyVStack(spacing: 8) {
				ForEach(weekdayProvider.entries, id: \.self) { entry in
					switch entry {
					case let .headline(date, isExcluded):
						WeekdayHeaderView(
							date: date,
							weekdayProvider: weekdayProvider,
							isExcluded: isExcluded
						) { date in
							showNewTodo(date)
						}
						.padding(.horizontal, 58)
						.padding(.top, 24)
						.padding(.bottom, 12)
						.offset(y: 8)
						
						if isExcluded {
							ContentUnavailableView {
								Label("Keine Aufgaben", systemImage: "beach.umbrella")
									.font(styleguide.title)
							} description: {
								Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
									.font(styleguide.body)
									.padding(.horizontal)
									.padding(.top, 8)
							}
						}
						
					case let .item(id, title, isDone, priority):
						TodoRow(
							id: id,
							title: title,
							isDone: isDone,
							priority: priority,
							repository: todoRepository,
							focussed: $focussedTodoID
						)
							.padding(.horizontal, 12)
							.contextMenu {
								if !isDone {
									TodoContextMenu(id: id, priority: priority)
								}
							}
					}
				}
			}		
			.toolbar {
				ToolbarItems()
			}
			.animation(.snappy, value: weekdayProvider.entries)
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
