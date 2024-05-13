//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import Foundation
import SwiftUI


public extension Styleguide {
	struct FontStyle {
		public init(body: Font, headline: Font, title: Font, largeTitle: Font, caption: Font) {
			self.body = body
			self.headline = headline
			self.title = title
			self.largeTitle = largeTitle
			self.caption = caption
		}
		
		public let body: Font
		public let headline: Font
		public let title: Font
		public let largeTitle: Font
		public let caption: Font
	}
}


public extension Styleguide {
	subscript(_ keyPath: KeyPath<FontStyle, Font>) -> Font {
		fonts[keyPath: keyPath]
	}
}
