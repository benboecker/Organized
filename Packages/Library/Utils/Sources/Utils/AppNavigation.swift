//
//  File.swift
//  Utils
//
//  Created by Benjamin Böcker on 21.07.24.
//

import Foundation
import Observation
import SwiftUI



@Observable
public class AppNavigation {
	fileprivate init(
		displayMode: TodoListDisplayMode = .list,
		newTodoDate: Date? = nil,
		showsAppInfo: Bool = false,
		showsOnboarding: Bool = false
	) {
		self.displayMode = displayMode
		self.newTodoDate = newTodoDate
		self.showsAppInfo = showsAppInfo
		self.showsOnboarding = showsOnboarding
	}
	
	public var displayMode: TodoListDisplayMode
	public var newTodoDate: Date?
	public var showsAppInfo: Bool
	public var showsOnboarding: Bool
}


public extension AppNavigation {
	enum TodoListDisplayMode {
		case list
		case pages
	}
	
	static let pages = AppNavigation(displayMode: .pages)
	static let appInfo = AppNavigation(showsAppInfo: true)
	static let newTodo = AppNavigation(newTodoDate: nil)
	static let newTodoWithDate = AppNavigation(newTodoDate: .now.addingTimeInterval(86400 * 2))
	static func showingOnboarding(_ showOnboarding: Bool) -> AppNavigation { AppNavigation(showsOnboarding: showOnboarding) }
}


public extension EnvironmentValues {
	@Entry var appNavigation: AppNavigation = AppNavigation()
}
