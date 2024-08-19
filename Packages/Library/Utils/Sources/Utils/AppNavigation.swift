//
//  File.swift
//  Utils
//
//  Created by Benjamin Böcker on 21.07.24.
//

import Foundation
import Observation
import SwiftUI



public enum AppNavi {
	case onboarding
	case appInfo
	case newTodo(date: Date?)
	case existingTodo(id: UUID)
}



@Observable
public class AppNavigation {
	fileprivate init(
		newTodoDate: Date? = nil,
		showsAppInfo: Bool = false,
		showsOnboarding: Bool = false
	) {
		self.newTodoDate = newTodoDate
		self.showsAppInfo = showsAppInfo
		self.showsOnboarding = showsOnboarding
	}
	
	public var newTodoDate: Date?
	public var showsAppInfo: Bool
	public var showsOnboarding: Bool
}


// For use in previews
public extension AppNavigation {
	static let appInfo = AppNavigation(showsAppInfo: true)
	static let newTodo = AppNavigation(newTodoDate: nil)
	static let newTodoWithDate = AppNavigation(newTodoDate: .now.addingTimeInterval(86400 * 2))
	static func onboarding(_ showOnboarding: Bool) -> AppNavigation { AppNavigation(showsOnboarding: showOnboarding) }
}


public extension EnvironmentValues {
	@Entry var appNavigation: AppNavigation = AppNavigation()
}
