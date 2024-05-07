//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Foundation
import SwiftUI

public extension Styleguide {
	enum Color {
		case primaryText
		case secondaryText
		case accent
		case primaryBackground
		case secondaryBackground
		
		var keyPath: KeyPath<Styleguide.Colors, SwiftUI.Color> {
			switch self {
			case .primaryText: \.primaryText
			case .secondaryText: \.secondaryText
			case .accent: \.accent
			case .primaryBackground: \.primaryBackground
			case .secondaryBackground: \.secondaryBackground
			}
		}
	}

	struct Colors {
		public init(primaryText: SwiftUI.Color, secondaryText: SwiftUI.Color, accent: SwiftUI.Color, primaryBackground: SwiftUI.Color, secondaryBackground: SwiftUI.Color) {
			self.primaryText = primaryText
			self.secondaryText = secondaryText
			self.accent = accent
			self.primaryBackground = primaryBackground
			self.secondaryBackground = secondaryBackground
		}
		
		public let primaryText: SwiftUI.Color
		public let secondaryText: SwiftUI.Color
		public let accent: SwiftUI.Color
		public let primaryBackground: SwiftUI.Color
		public let secondaryBackground: SwiftUI.Color
	}
}


struct ColorModifier: ViewModifier {
	@Environment(\.styleguide) private var styleguide
	let color: Styleguide.Color
	let foreground: Bool
	
	func body(content: Content) -> some View {
		if foreground {
			content.foregroundStyle(
				styleguide.colors[keyPath: color.keyPath]
			)
		} else {
			content.background(
				styleguide.colors[keyPath: color.keyPath]
			)
		}
	}
}

struct TintModifier: ViewModifier {
	@Environment(\.styleguide) private var styleguide
	let color: Styleguide.Color
	
	func body(content: Content) -> some View {
		content.tint(
			styleguide.colors[keyPath: color.keyPath]
		)
	}
}


public extension View {
	func color(foreground color: Styleguide.Color) -> some View {
		self.modifier(ColorModifier(color: color, foreground: true))
	}

	func color(background color: Styleguide.Color) -> some View {
		self.modifier(ColorModifier(color: color, foreground: false))
	}
	
	func tint(_ color: Styleguide.Color) -> some View {
		self.modifier(TintModifier(color: color))
	}
}

