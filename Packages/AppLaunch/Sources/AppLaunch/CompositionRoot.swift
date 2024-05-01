//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Alerts
import NewTodoUI
import NewTodoData
import NewTodoDomain
import Persistence
import SwiftUI
import TodoListUI
import TodoListData
import TodoListDomain
import Styleguide


struct CompositionRoot: View {
    
	private let persistentContainer: PersistentContainer
	@State private var todoRepository: TodoRepository
	@State private var weekdayProvider: WeekdayProvider
	@State private var newTodoCreation: NewTodoCreation
	@State private var showNewTodo = false
	@State private var newTodoDate: Date? = nil
	
	init() {
		self.persistentContainer = PersistentContainer(with: .testing)
		
		self._todoRepository = State(initialValue: PersistentTodoRepository())
		self._weekdayProvider = State(initialValue: PersistentWeekdayProvider(persistentContainer: persistentContainer))
		self._newTodoCreation = State(initialValue: PersistentNewTodoCreation())
	}
	
	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			TodoListView(
				todoRepository: todoRepository,
				weekdayProvider: weekdayProvider
			) { date in
				newTodoDate = date
				showNewTodo = true
			}
			
			NewTodoButton()
		}
		.sheet(isPresented: $showNewTodo) {
			NewTodoView(newTodoCreation: newTodoCreation, dueDate: newTodoDate)
		}
		.onAppear {
			persistentContainer.createDemoData()
		}
	}
}


private extension CompositionRoot {
	
	private func NewTodoButton() -> some View {
		Button {
//			withAnimation(.snappy) {
				showNewTodo = true
//			}
		} label: {
			Image(systemName: "plus")
				.font(.title2.bold())
				.frame(minWidth: 32, minHeight: 32)
				.foregroundStyle(Color.primary)
				.padding(8)
				.background(
					.thinMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 2, y: 2)),
					in: .circle
				)
				.padding(.trailing)
				.padding(.bottom)
		}
	}

	
}



#Preview {
	CompositionRoot()
}
