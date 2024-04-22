//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 20.04.24.
//

import SwiftUI


struct ShowcaseView: View {
    var body: some View {
		ScrollView {
			VStack(spacing: 24) {
				Text("Colors")
					.font(.system(.largeTitle, weight: .bold))
					.frame(maxWidth: .infinity, alignment: .leading)

				VStack(alignment: .leading, spacing: 24) {
					HStack {
						ColorPreview("Primary Text", color: .primaryText)
						ColorPreview("Secondary Text", color: .secondaryText)
					}
					HStack {
						ColorPreview("Primary Background", color: .primaryBackground)
						ColorPreview("Second. Background", color: .secondaryBackground)
					}
					HStack {
						ColorPreview("Accent", color: .accent)
						Color.clear
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding()

			Divider()
				.padding(.horizontal)

			VStack(spacing: 24) {
				Text("Fonts")
					.font(.system(.largeTitle, weight: .bold))
					.frame(maxWidth: .infinity, alignment: .leading)
				
				VStack(alignment: .leading, spacing: 24) {
					FontPreview("Caption", font: .caption)
					FontPreview("Body", font: .body)
					FontPreview("Headline", font: .headline)
					FontPreview("Title", font: .title)
					FontPreview("Large Title", font: .largeTitle)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding()
		}
    }

	func FontPreview(_ name: String, font: Styleguide.Font) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(name)
				.font(.system(.headline, weight: .bold))
				.foregroundStyle(.secondary.tertiary)
			Text("This is a quick FontStyle test")
				.fontStyle(font)

		}
	}

	func ColorPreview(_ name: String, color: Styleguide.Color) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(name)
				.font(.system(.headline, weight: .bold))
				.foregroundStyle(.secondary.tertiary)
			
			Color.clear
				.color(background: color)
				.clipShape(.rect(cornerRadius: 8))		
				.aspectRatio(1, contentMode: .fill)
				.shadow(color: .black.opacity(0.3), radius: 4, y: 2)
		}
	}
}



#Preview {
	ShowcaseView()
}
