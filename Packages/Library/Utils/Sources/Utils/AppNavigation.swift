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
	
	public var displayedSheet: Sheet?

	public init(showsOnboarding: Bool) {
		self.displayedSheet = showsOnboarding ? .onboarding : nil
	}
}

public extension AppNavigation {
	func performAction(_ action: Action) {
		switch action {
		case .showTodos:
			displayedSheet = nil

		case .showOnboarding:
			if displayedSheet == .appInfo(sheet: nil) {
				displayedSheet = .appInfo(sheet: .onboarding)
			} else {
				displayedSheet = .onboarding
			}
			
		case .closeOnboarding:
			if displayedSheet == .appInfo(sheet: .onboarding) {
				displayedSheet = .appInfo(sheet: nil)
			} else {
				displayedSheet = nil
			}
			
		case .showAppInfo:
			displayedSheet = .appInfo(sheet: nil)
			
		case .showTodoDetail(let id):
			displayedSheet = .todoDetail(id: id)

		case .showNewTodo(let date):
			displayedSheet = .newTodo(date: date)
			
		case .showPaywall:
			if displayedSheet == .appInfo(sheet: nil) {
				displayedSheet = .appInfo(sheet: .paywall)
			}
		}
	}
	
	var showsAppInfo: Binding<Bool> {
		Binding { [weak self] in
			self?.displayedSheet == .appInfo(sheet: nil)
		} set: { [weak self] newValue in
			self?.displayedSheet = nil
		}
	}

//	var showsAppInfoOnboarding: Binding<Bool> {
//		Binding { [weak self] in
//			self?.displayedSheet?.showsAppInfoOnboarding ?? false
//		} set: { [weak self] newValue in
//			self?.displayedSheet = newValue ? .appInfo(screen: .onboarding) : nil
//		}
//	}
	
	var showsOnboarding: Binding<Bool> {
		Binding { [weak self] in
			self?.displayedSheet?.isOnboarding == true
		} set: { [weak self] newValue in
			if self?.displayedSheet == .appInfo(sheet: .onboarding) {
				self?.displayedSheet = .appInfo(sheet: nil)
			} else {
				self?.displayedSheet = newValue ? .onboarding : nil
			}			
		}
	}
	
	var newTodoDate: Binding<Date?> {
		Binding { [weak self] in
			self?.displayedSheet?.todoDetailDate
		} set: { [weak self] newValue in
			if let newValue {
				self?.displayedSheet = .newTodo(date: newValue)
			} else {
				self?.displayedSheet = nil
			}
		}
	}
}



public extension AppNavigation {
	enum Action {
		case showTodos
		case showOnboarding
		case closeOnboarding
		case showTodoDetail(id: UUID)
		case showNewTodo(date: Date)
		case showAppInfo
		case showPaywall
	}
}



public indirect enum Sheet: Equatable, Identifiable {
	case onboarding
	case appInfo(sheet: Sheet?)
	case newTodo(date: Date)
	case todoDetail(id: UUID)
	case paywall
	
	public var id: String {
		"\(self)"
	}
	
	public var isOnboarding: Bool {
		switch self {
		case .onboarding:
			return true
		case .appInfo(let sheet):
			return sheet?.isOnboarding == true
		default:
			return false
		}
	}
	
	public var todoDetailDate: Date? {
		guard case .newTodo(let date) = self else {
			return nil
		}
		
		return date
	}
	
	
	
//	public var showsAppInfo: Bool {
//		guard case .appInfo = self else { return false }
//		return true
////		return appInfoScreen == .main
//	}
//	
//	public var showsOnboarding: Bool {
//		guard case .appInfo(let appInfoScreen) = self else { return false }
//		return appInfoScreen == .onboarding
//	}
//	
//	public var showsAppInfoPaywall: Bool {
//		guard case .appInfo(let appInfoScreen) = self else { return false }
//		return appInfoScreen == .paywall
//	}
}




public extension EnvironmentValues {
	@Entry var appNavigation: AppNavigation = AppNavigation(showsOnboarding: false)
}
