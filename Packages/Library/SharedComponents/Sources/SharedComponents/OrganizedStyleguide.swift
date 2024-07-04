//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.05.24.
//

import Foundation
import Styleguide
import SwiftUITools
import SwiftUI


public extension Styleguide {
	static let organized = Styleguide(
		fonts: FontStyle(
			body:       .system(.body,       design: .serif,   weight: .medium),
			headline:   .system(.headline,   design: .serif,   weight: .heavy),
			title:      .system(.title2,     design: .serif,   weight: .heavy),
			largeTitle: .system(.largeTitle, design: .serif,   weight: .heavy),
			caption:    .system(.caption,    design: .serif,   weight: .bold)
		),
		colors: ColorStyle(
			primaryText:         .init(light: "#111111", dark: "#EEEEEE"),
			secondaryText:       .init(light: "#999999", dark: "#CCCCCC"),
			accent:              .init(light: "#e84118", dark: "#e84118"),
			primaryBackground:   .init(light: "#FEFEFE", dark: "#111111"),
			secondaryBackground: .init(light: "#EEEEEE", dark: "#222222")
		),
		spacing: Spacing(
		    extraSmall: 4,
			     small: 4,
			    medium: 8,
				 large: 16,
			extraLarge: 32
		)
	)
}



public extension View {
	func styledPreview() -> some View {
		self.styledPreview(.organized)
	}
}
