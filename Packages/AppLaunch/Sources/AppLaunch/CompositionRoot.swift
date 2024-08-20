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
import Utils


struct CompositionRoot: View {
	@State private var settings: Settings
	@State private var appNavigation: AppNavigation
	@State private var todoRepository = PersistentTodoRepository(container: .testing)
	@State private var todoListProvider: TodoListProvider
	@State private var newTodoCreation = PersistentNewTodoCreation(container: .testing)
	@State private var styleguide = Styleguide.organized
	
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
		self._appNavigation = State(initialValue: AppNavigation(showsOnboarding: !settings.didShowOnboarding))
	}
	
	var body: some View {
		@Bindable var appNavigation = appNavigation
		ZStack(alignment: .bottom) {
			TodoContainerView()
		}
		.onAppear {
			settings.observeChanges()
			todoListProvider.startObserving()
		}
		.sheet(isPresented: appNavigation.showsAppInfo) {
			AppInfoView()
				.sheet(isPresented: appNavigation.showsOnboarding) {
					OnboardingView()
						.interactiveDismissDisabled()
				}
		}
		.sheet(isPresented: appNavigation.showsOnboarding) {
			OnboardingView()
				.interactiveDismissDisabled()
		}

		
//		.sheet(item: appNavigation.newTodoDate, content: { new in
//			NewTodo(date: new)
//		})

		.environment(\.styleguide, styleguide)
		.environment(\.settings, settings)
		.environment(\.todoRepository, todoRepository)
		.environment(\.todoListProvider, todoListProvider)
		.environment(\.newTodoCreation, newTodoCreation)
		.environment(\.appNavigation, appNavigation)
	}
	
	let alertConfig = DisplayConfig(
		enableBackgroundBlur: false,
		enableOutsideTap: true,
		transitionType: .slide,
		slideEdge: .bottom
	)
	
	func NewTodo(date: Date) -> some View {
		NewNewTodoView(date: date)
			.environment(\.styleguide, styleguide)
			.environment(\.settings, settings)
			.environment(\.todoRepository, todoRepository)
			.environment(\.todoListProvider, todoListProvider)
			.environment(\.newTodoCreation, newTodoCreation)
			.environment(\.appNavigation, appNavigation)
			.padding(styleguide.large)
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
