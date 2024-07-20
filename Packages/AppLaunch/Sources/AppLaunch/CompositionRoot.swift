//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Alerts
import AppInfoUI
import NewTodoUI
import NewTodoData
import NewTodoDomain
import OnboardingUI
import OnboardingDomain
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
		
		let settings: Settings
#if DEBUG
		settings = .testing
#else
		settings = Settings()
#endif
		
		self._settings = State(initialValue: settings)
		self._todoListProvider = State(initialValue: PersistentTodoListProvider(container: .testing, settings: settings))
	}
	
	var body: some View {
		ZStack(alignment: .bottom) {
			NavigationStack {
				TodoListView { date in
					newTodoDate = date
				} showSettings: {
					showAppInfo = true
				}
			}
			
//			BottomButtonBar()
		}
		.statusBarBlur(fixedBlur: false)
		.onAppear {
			settings.observeChanges()
			todoListProvider.startObserving()
		}
		.alert(item: $newTodoDate) { newTodoDate in
			NewTodoView(dueDate: newTodoDate)
		}
		.alert(isPresented: $showNewTodo, displayConfig: DisplayConfig(
			enableBackgroundBlur: true,
			disableOutsideTap: true,
			transitionType: .slide,
			slideEdge: .bottom
		)) {
			NewTodoView()
				.padding(30)
		}
//		.sheet(item: $newTodoDate) { newTodoDate in
//			NewTodoView(dueDate: newTodoDate)
//		}
//		.sheet(isPresented: $showNewTodo) {
//			NewTodoView()
//		}
		.sheet(isPresented: $showAppInfo) {
			AppInfoView()
				.sheet(isPresented: $settings.showOnboarding) {
					OnboardingView()
				}
		}
		.sheet(isPresented: $settings.showOnboarding) {
			OnboardingView()
				.interactiveDismissDisabled()
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


#Preview {
	CompositionRoot()
		.styledPreview()
}
