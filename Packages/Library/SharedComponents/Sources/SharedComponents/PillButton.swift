//
//  File.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 13.07.24.
//

import Foundation
import SwiftUI



public struct PillButton: View {
	
	public init(
		title: String,
		imageName: String? = nil,
		action: @escaping () -> Void
	) {
		self.title = title
		self.imageName = imageName
		self.action = action
	}
	
	private let title: String
	private let imageName: String?
	private let action: () -> Void
	
	public var body: some View {
		Button(title, systemImage: imageName ?? "", action: action)
			.buttonStyle(.pill(textOnly: imageName == nil))
	}
	
}


struct PillButtonStyle: ButtonStyle {
	
	@Environment(\.styleguide) private var styleguide
	let textOnly: Bool
	
	func makeBody(configuration: Configuration) -> some View {
		VStack {
			if textOnly {
				configuration.label
					.labelStyle(.titleOnly)
			} else {
				configuration.label
					.labelStyle(.titleAndIcon)
			}
		}
		.font(styleguide.headline)
		.foregroundStyle(styleguide.primaryText)
		.padding(.vertical, styleguide.medium)
		.padding(.horizontal, styleguide.large)
		.background(styleguide.secondaryBackground, in: .capsule)
	}
}

extension ButtonStyle where Self == PillButtonStyle {
	static func pill(textOnly: Bool) -> PillButtonStyle { PillButtonStyle(textOnly: textOnly) }
}



#Preview {
	VStack(spacing: 32) {
		PillButton(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward") { }
		PillButton(title: "Tag einplanen") { }
	}
	.styledPreview()
}
