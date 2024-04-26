//
//  VisibilityConfig.swift
//  AlertTest
//
//  Created by Benjamin Böcker on 02.04.24.
//

import Foundation
import SwiftUI


public struct DisplayConfig {
	public init(enableBackgroundBlur: Bool = true, disableOutsideTap: Bool = false, transitionType: TransitionType = .slide, slideEdge: Edge = .bottom) {
		self.enableBackgroundBlur = enableBackgroundBlur
		self.disableOutsideTap = disableOutsideTap
		self.transitionType = transitionType
		self.slideEdge = slideEdge
		self.durationIn = 0.35
		self.durationOut = 0.35
	}
	
	public static let nonBlurred = DisplayConfig(
		enableBackgroundBlur: false,
		disableOutsideTap: false,
		transitionType: .slide,
		slideEdge: .bottom
	)
	
	let durationIn: TimeInterval
	let durationOut: TimeInterval
	let enableBackgroundBlur: Bool
	let disableOutsideTap: Bool
	let transitionType: TransitionType
	let slideEdge: Edge
	
	public enum TransitionType {
		case slide, fade
	}
}
