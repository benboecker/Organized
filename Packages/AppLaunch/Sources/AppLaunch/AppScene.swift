//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 19.04.24.
//

import Foundation
import SwiftUI
//import Persistence
//import URLInformation
//import ViewState
//import SharedUI


@MainActor
public struct AppScene: Scene {

//	private let persistentContainer: PersistentContainer
//
//	@State private var displayMode = DisplayMode()
//	@State private var filterOptions = FilterOptions()
//	@State private var bookmarksDataStore: BookmarksDataStore

	public init() {
//		self.persistentContainer = PersistentContainer()
//		self.bookmarksDataStore = BookmarksDataStore(persistentContainer: persistentContainer)
//
//		UIKitAppearance.configure()
	}


	public var body: some Scene {
		WindowGroup {
			CompositionRoot()
//				.tint(Color.accent)
		}
//		.environment(filterOptions)
//		.environment(displayMode)
//		.environment(bookmarksDataStore)
//		.environment(\.managedObjectContext, persistentContainer.mainContext)
	}
}
