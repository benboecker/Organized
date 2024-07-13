//
//  RoundedButtonStyle.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 13.07.24.
//

import SwiftUI
import Styleguide



public struct RoundedButton: View {
	public enum Size {
		case large, small
	}
	
	public init(image: String, size: Size = .large, action: @escaping () -> Void) {
		self.image = image
		self.size = size
		self.action = action
	}
	
	private let image: String
	private let size: Size
	private let action: () -> Void

	public var body: some View {
		Button("", systemImage: image, action: action)
			.buttonStyle(.rounded(size: size))
	}
	
}




struct RoundedButtonStyle: ButtonStyle {
	@Environment(\.styleguide) private var styleguide
	
	init(size: RoundedButton.Size) {
		self.size = size
	}
	
	private let size: RoundedButton.Size
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.labelStyle(.iconOnly)
			.font(font)
			.frame(width: width, height: width)
			.foregroundStyle(styleguide.primaryText)
			.padding(styleguide.medium)
			.background(
				.thinMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 2, y: 2)),
				in: .circle
			)
	}
	
	var font: Font {
		switch size {
		case .large: styleguide.body.weight(.bold)
		case .small: styleguide.caption.weight(.heavy)
		}
	}
	
	var padding: CGFloat {
		switch size {
		case .large: styleguide.medium
		case .small: styleguide.extraSmall
		}
	}
	
	var width: CGFloat {
		switch size {
		case .large: styleguide.extraLarge
		case .small: styleguide.large
		}
	}
}

extension ButtonStyle where Self == RoundedButtonStyle {
	static func rounded(size: RoundedButton.Size) -> RoundedButtonStyle { RoundedButtonStyle(size: size) }
}


#Preview {
	Grid(horizontalSpacing: 32, verticalSpacing: 32) {
		GridRow {
			RoundedButton(image: "plus") { print("pressed") }
			RoundedButton(image: "house") { print("pressed") }
			RoundedButton(image: "tag") { print("pressed") }
		}
		GridRow {
			RoundedButton(image: "plus", size: .small) { print("pressed") }
			RoundedButton(image: "house", size: .small) { print("pressed") }
			RoundedButton(image: "tag", size: .small) { print("pressed") }
		}
	}
	.padding()
	.styledPreview()
}
