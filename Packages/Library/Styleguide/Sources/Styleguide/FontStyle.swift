//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Foundation
import SwiftUI


public extension Styleguide {
	enum Font {
		case body
		case headline
		case title
		case largeTitle
		case caption

		var keyPath: KeyPath<Styleguide.Fonts, SwiftUI.Font> {
			switch self {
			case .body: \.body
			case .headline: \.headline
			case .title: \.title
			case .largeTitle: \.largeTitle
			case .caption: \.caption
			}
		}
	}

	struct Fonts {
		public init(body: SwiftUI.Font, headline: SwiftUI.Font, title: SwiftUI.Font, largeTitle: SwiftUI.Font, caption: SwiftUI.Font) {
			self.body = body
			self.headline = headline
			self.title = title
			self.largeTitle = largeTitle
			self.caption = caption
		}
		
		let body: SwiftUI.Font
		let headline: SwiftUI.Font
		let title: SwiftUI.Font
		let largeTitle: SwiftUI.Font
		let caption: SwiftUI.Font

	}
}



struct FontStyleModifier: ViewModifier {
	@Environment(\.styleguide) private var styleguide
	let access: Styleguide.Font


	func body(content: Content) -> some View {
		content.font(
			styleguide.fonts[keyPath: access.keyPath]
		)
	}
}

public extension View {
	func fontStyle(_ access: Styleguide.Font) -> some View {
		self.modifier(FontStyleModifier(access: access))
	}
}
