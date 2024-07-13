//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 04.07.24.
//

import SwiftUI
import TodoListDomain
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
		VStack(spacing: styleguide.medium) {
			Image(systemName: "beach.umbrella")
				.font(.system(.largeTitle, weight: .medium))
				.foregroundStyle(styleguide.primaryText)
				.padding(.bottom, styleguide.large)
			
			WeekdayView(date: date)
			
			Text("Entspann dich, an diesem Tag gibt es keine Aufgaben.")
				.font(styleguide.body)
				.foregroundStyle(styleguide.primaryText)
				.padding(.horizontal)
				.multilineTextAlignment(.center)
			
			if isManuallyExcluded {
				Button {
					withAnimation(.snappy) {
						settings.toggleManuallyExclude(date: date)
						todoListProvider.regenerate()
					}
				} label: {
					Text("Tag einplanen")
						.font(styleguide.headline)
						.foregroundStyle(styleguide.primaryText)
						.padding(.vertical, styleguide.medium)
						.padding(.horizontal, styleguide.large)
						.background(styleguide.secondaryBackground, in: .capsule)
				}
				.padding(.top, styleguide.large)
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
