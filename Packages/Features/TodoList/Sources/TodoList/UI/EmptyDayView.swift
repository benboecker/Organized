//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 04.07.24.
//

import SwiftUI
import Styleguide
import SharedComponents
import Settings


struct EmptyDayView: View {
	let date: Date
	let isManuallyExcluded: Bool
	
	@Environment(\.styleguide) private var styleguide
	@Environment(\.todoListProvider) private var todoListProvider
	@Environment(\.settings) private var settings

	var body: some View {
		VStack(spacing: styleguide.large) {
			Image(systemName: "beach.umbrella")
				.font(.system(.largeTitle, weight: .medium))
				.foregroundStyle(styleguide.foregroundPrimary)
			
			VStack(spacing: styleguide.small) {
				WeekdayView(date: date)
				Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
					.font(styleguide.body1)
					.foregroundStyle(styleguide.foregroundPrimary)
					.padding(.horizontal)
					.multilineTextAlignment(.center)
			}
			
			if isManuallyExcluded {
				OrganizedButton(
					title: "Tag einplanen",
					imageName: "calendar"
				) {
					withAnimation(.snappy) {
						settings.toggleManuallyExclude(date: date)
						todoListProvider.regenerate()
					}
				}
			}
		}
	}
}


#Preview {
	VStack(spacing: 48) {
		EmptyDayView(date: .now, isManuallyExcluded: false)
		Divider()
		EmptyDayView(date: .now, isManuallyExcluded: true)
	}
	.styledPreview()
	.padding()
}
