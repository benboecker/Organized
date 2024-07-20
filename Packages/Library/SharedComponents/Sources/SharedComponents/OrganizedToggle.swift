//
//  File.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 13.07.24.
//

import Foundation
import SwiftUI



public struct OrganizedToggle: View {
	public enum Variant {
		case icon
		case text
		case iconAndText(leading: Bool = true)
	}
	
	public init(
		title: String? = nil,
		imageName: String? = nil,
		isOn: Binding<Bool>
	) {
		self.title = title ?? ""
		self.imageName = imageName
		self._isOn = isOn
		
		if imageName == nil {
			self.variant = .text
		} else if title == nil {
			self.variant = .icon
		} else {
			self.variant = .iconAndText(leading: true)
		}
	}
	
	private init(title: String, imageName: String?, variant: OrganizedToggle.Variant, isOn: Binding<Bool>) {
		self.title = title
		self.imageName = imageName
		self.variant = variant
		self._isOn = isOn
	}
	
	private let title: String
	private let imageName: String?
	private let variant: Variant
	@Binding private var isOn: Bool
	
	public var body: some View {
		Toggle(title, systemImage: imageName ?? "", isOn: $isOn)
			.toggleStyle(.toggle(variant: variant))
	}
	
	public func variant(_ variant: Variant) -> some View {
		OrganizedToggle(
			title: title,
			imageName: imageName,
			variant: variant,
			isOn: $isOn
		)
	}
}


struct OrganizedToggleStyle: ToggleStyle {
	@Environment(\.styleguide) private var styleguide
	let variant: OrganizedToggle.Variant
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.onTapGesture {
				withAnimation(.snappy) {
					configuration.isOn.toggle()
				}
			}
			.labelStyle(OrganizedToggleLabelStyle(variant: variant, isOn: configuration.isOn))
	}
}

extension ToggleStyle where Self == OrganizedToggleStyle {
	static func toggle(variant: OrganizedToggle.Variant) -> OrganizedToggleStyle { OrganizedToggleStyle(variant: variant) }
}


struct OrganizedToggleLabelStyle: LabelStyle {
	@Environment(\.styleguide) private var styleguide
	let variant: OrganizedToggle.Variant
	let isOn: Bool
	
	func makeBody(configuration: Configuration) -> some View {
		VStack {
			switch variant {
			case .icon:
				configuration.icon
					.font(styleguide.headline)
					.foregroundStyle(isOn ? styleguide.tertiaryText : styleguide.secondaryText)
					.padding(.vertical, styleguide.medium)
					.padding(.horizontal, styleguide.large)
					.background(isOn ? styleguide.secondaryText : styleguide.secondaryBackground, in: .circle)
			case .text:
				configuration.title
					.font(styleguide.headline)
					.foregroundStyle(isOn ? styleguide.tertiaryText : styleguide.secondaryText)
					.padding(.vertical, styleguide.medium)
					.padding(.horizontal, styleguide.large)
					.background(isOn ? styleguide.secondaryText : styleguide.secondaryBackground, in: .capsule)
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
				.foregroundStyle(isOn ? styleguide.tertiaryText : styleguide.secondaryText)
				.padding(.vertical, styleguide.medium)
				.padding(.horizontal, styleguide.large)
				.background(isOn ? styleguide.secondaryText : styleguide.secondaryBackground, in: .capsule)
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
