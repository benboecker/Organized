//
//  File.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 13.07.24.
//

import Foundation
import SwiftUI



public struct OrganizedButton: View {
	public enum Variant {
		case icon
		case text
		case iconAndText(leading: Bool = true)
	}
	
	public init(
		title: String? = nil,
		imageName: String? = nil,
		action: @escaping () -> Void
	) {
		self.title = title ?? ""
		self.imageName = imageName
		self.action = action
		
		if imageName == nil {
			self.variant = .text
		} else if title == nil {
			self.variant = .icon
		} else {
			self.variant = .iconAndText(leading: true)
		}
	}
	
	private init(title: String, imageName: String?, variant: OrganizedButton.Variant, action: @escaping () -> Void) {
		self.title = title
		self.imageName = imageName
		self.variant = variant
		self.action = action
	}
	
	private let title: String
	private let imageName: String?
	private let variant: Variant
	private let action: () -> Void
	
	public var body: some View {
		Button(title, systemImage: imageName ?? "", action: action)
			.buttonStyle(.organized(variant: variant))
	}
	
	public func variant(_ variant: Variant) -> some View {
		OrganizedButton(title: title, imageName: imageName, variant: variant, action: action)
	}
}


struct OrganizedButtonStyle: ButtonStyle {
	@Environment(\.styleguide) private var styleguide
	let variant: OrganizedButton.Variant
		
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.labelStyle(OrganizedButtonLabelStyle(variant: variant, isPressed: configuration.isPressed))
	}
}

extension ButtonStyle where Self == OrganizedButtonStyle {
	static func organized(variant: OrganizedButton.Variant) -> OrganizedButtonStyle { OrganizedButtonStyle(variant: variant) }
}


struct OrganizedButtonLabelStyle: LabelStyle {
	@Environment(\.styleguide) private var styleguide
	let variant: OrganizedButton.Variant
	let isPressed: Bool

	func makeBody(configuration: Configuration) -> some View {
		VStack {
			switch variant {
			case .icon:
				configuration.icon
					.font(styleguide.headline)
					.foregroundStyle(isPressed ? styleguide.tertiaryText : styleguide.primaryText)
					.padding(.vertical, styleguide.medium)
					.padding(.horizontal, styleguide.large)
					.frame(minWidth: 42, minHeight: 42)
					.background(isPressed ? styleguide.secondaryText : styleguide.secondaryBackground, in: .circle)
			case .text:
				configuration.title
					.font(styleguide.headline)
					.foregroundStyle(isPressed ? styleguide.tertiaryText : styleguide.primaryText)
					.padding(.vertical, styleguide.medium)
					.padding(.horizontal, styleguide.large)
					.background(isPressed ? styleguide.secondaryText : styleguide.secondaryBackground, in: .capsule)
			case .iconAndText(let leading):
				HStack {
					if leading {
						configuration.icon
						configuration.title
					} else {
						configuration.title
						configuration.icon
					}
				}
				.font(styleguide.headline)
				.foregroundStyle(isPressed ? styleguide.tertiaryText : styleguide.primaryText)
				.padding(.vertical, styleguide.medium)
				.padding(.horizontal, styleguide.large)
				.background(isPressed ? styleguide.secondaryText : styleguide.secondaryBackground, in: .capsule)
			}
		}
	}
}



#Preview {
	@Previewable @State var isOn = false
	VStack(spacing: 64) {
		VStack(spacing: 16) {
			OrganizedButton(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward") { }
			OrganizedButton(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward") { }
				.variant(.iconAndText(leading: false))
			OrganizedButton(title: "Tag einplanen") { }
			OrganizedButton(imageName: "arrow.down.backward.and.arrow.up.forward") { }
		}
		VStack(spacing: 16) {
			OrganizedToggle(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward", isOn: $isOn)
			OrganizedToggle(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward", isOn: $isOn)
				.variant(.iconAndText(leading: false))
			OrganizedToggle(title: "Tag einplanen", isOn: $isOn)
			OrganizedToggle(imageName: "arrow.down.backward.and.arrow.up.forward", isOn: $isOn)
		}
	}
	.styledPreview()
}
