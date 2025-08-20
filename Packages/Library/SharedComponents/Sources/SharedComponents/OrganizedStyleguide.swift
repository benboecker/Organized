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
//	static let organized = Styleguide(
//		fonts: FontStyle(
//			headline1: <#T##Font#>,
//			headline2: <#T##Font#>,
//			headline3: <#T##Font#>,
//			headline4: <#T##Font#>,
//			body1: <#T##Font#>,
//			body2: <#T##Font#>,
//			caption1: <#T##Font#>,
//			caption2: <#T##Font#>
//		),
//		colors: ColorStyle(
//			foregroundPrimary: <#T##DynamicColor#>,
//			foregroundSecondary: <#T##DynamicColor#>,
//			foregroundTertiary: <#T##DynamicColor#>,
//			backgroundPrimary: <#T##DynamicColor#>,
//			backgroundSecondary: <#T##DynamicColor#>,
//			backgroundTertiary: <#T##DynamicColor#>,
//			accentPrimary: <#T##DynamicColor#>,
//			accentSecondary: <#T##DynamicColor#>,
//			accentTertiary: <#T##DynamicColor#>,
//			confirmation: <#T##DynamicColor#>,
//			warning: <#T##DynamicColor#>,
//			error: <#T##DynamicColor#>
//		),
//		spacing: Spacing(
//			extraSmall: 4,
//			small: 4,
//			medium: 8,
//			large: 16,
//			extraLarge: 32
//		),
//		shadows: Shadows(
//			small: .,
//			large: <#T##Shadow#>
//		)
//	)
}



public extension View {
	func styledPreview() -> some View {
		self.styledPreview(using: .default)
	}
}
