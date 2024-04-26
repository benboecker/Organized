//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import Styleguide



public extension View {
	func body() -> some View {
		self
			.fontStyle(.body)
			.color(foreground: .primaryText)
	}
	
	func headline() -> some View {
		self
			.fontStyle(.headline)
			.color(foreground: .primaryText)
	}
	
	func title() -> some View {
		self
			.fontStyle(.title)
			.color(foreground: .primaryText)
	}
	
	func largeTitle() -> some View {
		self
			.fontStyle(.largeTitle)
			.color(foreground: .primaryText)
	}
	
	func caption() -> some View {
		self
			.fontStyle(.caption)
			.color(foreground: .secondaryText)
	}
}
