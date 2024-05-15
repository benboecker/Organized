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
									.font(styleguide[\.title])
							} description: {
								Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
									.font(styleguide[\.body])
									.padding(.horizontal)
									.padding(.top, 8)
							}
						}
						
					case let .item(id, title, isDone, priority):
						TodoRow(id: id, title: title, isDone: isDone, priority: priority, repository: todoRepository)
							.padding(.horizontal, 12)
							.contextMenu {
								if !isDone {
									TodoContextMenu(id: id, priority: priority)
								}
							}
					}
				}
			}
			.animation(.snappy, value: weekdayProvider.entries)
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
}

#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	) { _ in }
}
