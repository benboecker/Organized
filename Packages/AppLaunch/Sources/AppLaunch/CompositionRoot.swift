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
import Settings


struct CompositionRoot: View {
	@State private var showNewTodo = false
	@State private var showAppInfo = false
	@State private var newTodoDate: Date? = nil
	@State private var settings: Settings
	@State private var todoRepository = PersistentTodoRepository(container: .testing)
	@State private var todoListProvider: TodoListProvider
	@State private var newTodoCreation = PersistentNewTodoCreation(container: .testing)
	@State private var styleguide = Styleguide.organized
	@State private var statusBarOpacity: Double = 0.0
	
	init() {
		print("CompositionRoot init")
		
		let settings = Settings()
		self._settings = State(initialValue: settings)
		self._todoListProvider = State(initialValue: PersistentTodoListProvider(container: .testing, settings: settings))
	}
	
	var body: some View {
		NavigationStack {
			TodoListView(statusBarOpacity: $statusBarOpacity) { date in
				newTodoDate = date
			} showSettings: {
				showAppInfo = true
			}
		}
		.onAppear {
			settings.observeChanges()
			todoListProvider.startObserving()
		}
		.overlay(alignment: .bottomTrailing) {
			NewTodoButton()
				.offset(x: -styleguide.large)
		}
		.overlay(alignment: .top) {
			Color.clear
				.background(.ultraThinMaterial)
				.opacity(statusBarOpacity)
				.ignoresSafeArea(edges: .top)
				.frame(height: 0) // This will constrain the overlay to only go above the top safe area and not under.
		}
		.sheet(item: $newTodoDate) { newTodoDate in
			NewTodoView(dueDate: newTodoDate)
		}
		.sheet(isPresented: $showNewTodo) {
			NewTodoView(dueDate: newTodoDate)
		}
		.environment(\.styleguide, styleguide)
		.environment(\.settings, settings)
		.environment(\.todoRepository, todoRepository)
		.environment(\.todoListProvider, todoListProvider)
		.environment(\.newTodoCreation, newTodoCreation)
	}
}


extension Date: @retroactive Identifiable {
	public var id: String {
		formatted()
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
		.styledPreview()
}
