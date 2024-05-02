//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import SwiftUI
import TodoListDomain



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
						weekdayProvider: weekdayProvider
					) { date in
						showNewTodo(date)
					}
					.padding(.horizontal, 58)
					.padding(.top, 24)
					.padding(.bottom, 12)
					.offset(y: 8)

					ForEach(weekday.todos) { todo in
						TodoRow(
							title: todo.title,
							isDone: todo.isDone,
							isImportant: todo.isImportant,
							repository: todoRepository
						)
						.padding(.horizontal, 12)
//						.debugFrame()
					}
				}
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
