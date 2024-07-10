//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 19.04.24.
//

import Foundation
import SwiftUI
import NewTodoUI
import NewTodoData
import NewTodoDomain
import Persistence
import SwiftUI
import TodoListUI
import TodoListData
import TodoListDomain
import Styleguide


@MainActor
public struct AppScene: Scene {
	
	public init() { }
	
	public var body: some Scene {
		WindowGroup {
			CompositionRoot()
				.onAppear {
					PersistentContainer.testing.createDemoData()
				}
		}
		.environment(\.styleguide, .organized)
		.environment(\.todoRepository, PersistentTodoRepository(container: .testing))
		.environment(\.weekdayProvider, PersistentTodoListProvider(persistentContainer: .testing))
		.environment(\.newTodoCreation, PersistentNewTodoCreation(container: .testing))
	}
}
