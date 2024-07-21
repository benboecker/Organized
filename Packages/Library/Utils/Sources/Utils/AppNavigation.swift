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
		newTodo: NewTodo = .notShown,
		showsAppInfo: Bool = false,
		showsOnboarding: Bool = false
	) {
		self.displayMode = displayMode
		self.newTodo = newTodo
		self.showsAppInfo = showsAppInfo
		self.showsOnboarding = showsOnboarding
	}
	
	public var displayMode: TodoListDisplayMode
	public var newTodo: NewTodo
	public var showsAppInfo: Bool
	public var showsOnboarding: Bool
}


public extension AppNavigation {
	enum TodoListDisplayMode {
		case list
		case pages
	}
	
	enum NewTodo {
		case notShown
		case withoutDate
		case withDate(Date)
	}
	
	static let pages = AppNavigation(displayMode: .pages)
	static let appInfo = AppNavigation(showsAppInfo: true)
	static let newTodo = AppNavigation(newTodo: .withoutDate)
	static let newTodoWithDate = AppNavigation(newTodo: .withDate(.now.addingTimeInterval(86400 * 2)))
	static func showingOnboarding(_ showOnboarding: Bool) -> AppNavigation { AppNavigation(showsOnboarding: showOnboarding) }
}


public extension EnvironmentValues {
	@Entry var appNavigation: AppNavigation = AppNavigation()
}
