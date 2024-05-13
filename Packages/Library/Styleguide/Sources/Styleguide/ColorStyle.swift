//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Foundation
import SwiftUI

public extension Styleguide {
	struct ColorStyle {
		public init(primaryText: Color, secondaryText: Color, accent: Color, primaryBackground: Color, secondaryBackground: Color) {
			self.primaryText = primaryText
			self.secondaryText = secondaryText
			self.accent = accent
			self.primaryBackground = primaryBackground
			self.secondaryBackground = secondaryBackground
		}
		
		public let primaryText: Color
		public let secondaryText: Color
		public let accent: Color
		public let primaryBackground: Color
		public let secondaryBackground: Color
	}
}

public extension Styleguide {
	subscript(_ keyPath: KeyPath<ColorStyle, Color>) -> Color {
		colors[keyPath: keyPath]
	}
}
