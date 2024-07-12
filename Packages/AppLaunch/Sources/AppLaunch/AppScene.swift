//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 19.04.24.
//

import Foundation
import Persistence
import SwiftUI


@MainActor
public struct AppScene: Scene {
	
	public init() {
		print("AppScene init")
	}
		
	public var body: some Scene {
		WindowGroup {
			CompositionRoot()
				.onAppear {
					PersistentContainer.testing.createDemoData()
				}
		}
	}
}
