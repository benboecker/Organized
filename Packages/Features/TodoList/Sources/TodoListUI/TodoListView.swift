//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import SwiftUI
import TodoListDomain



public struct TodoListView: View {
	public init(todoRepository: TodoRepository, weekdayProvider: WeekdayProvider) {
		self.weekdayProvider = weekdayProvider
		self.todoRepository = todoRepository
	}

	private let todoRepository: TodoRepository
	private let weekdayProvider: WeekdayProvider
	
	public var body: some View {
		ScrollView {
			LazyVStack(spacing: 0) {
				ForEach(weekdayProvider.weekdays, id: \.self) { weekday in
					WeekdayHeaderView(date: weekday.date)
						.padding(.horizontal, 58)
						.padding(.top, 40)
						.padding(.bottom, 6)
					
					ForEach(weekday.todos) { todo in
						TodoRow(
							title: todo.title,
							isDone: todo.isDone,
							isImportant: todo.isImportant,
							repository: todoRepository
						)
						.padding(.horizontal, 12)
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
	)
}
