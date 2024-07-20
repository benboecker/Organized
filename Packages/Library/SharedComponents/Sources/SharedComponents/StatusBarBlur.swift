//
//  File.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 20.07.24.
//

import Foundation
import SwiftUI


public struct StatusBarBlurModifier: ViewModifier {
	init(backgroundMaterial: Material = .ultraThinMaterial, fixedBlur: Bool = false) {
		self.backgroundMaterial = backgroundMaterial
		self.fixedBlur = fixedBlur
	}
	
	private let fixedBlur: Bool
	private let backgroundMaterial: Material
	@Environment(\.statusBarOpacity) private var statusBarOpacity
	
	public func body(content: Content) -> some View {
		content
			.overlay(alignment: .top) {
				Color.clear
					.background(backgroundMaterial)
					.opacity(fixedBlur ? 1.0 : statusBarOpacity.value)
					.ignoresSafeArea(edges: .top)
					.frame(height: 0) // This will constrain the overlay to only go above the top safe area and not under.
			}
	}
}

public extension View {
	func statusBarBlur(backgroundMaterial: Material = .ultraThinMaterial, fixedBlur: Bool = false) -> some View {
		modifier(StatusBarBlurModifier(backgroundMaterial: backgroundMaterial, fixedBlur: fixedBlur))
	}
}


@Observable
public class StatusBarOpacity {
	init(value: CGFloat) {
		self.value = value
	}
	
	public var value: CGFloat
}

public extension EnvironmentValues {
	@Entry var statusBarOpacity: StatusBarOpacity = StatusBarOpacity(value: 0.0)
}
