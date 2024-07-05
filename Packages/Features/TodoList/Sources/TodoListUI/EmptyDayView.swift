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


struct EmptyDayView: View {
	
	let date: Date
	let isExcluded: Bool
	
	@Environment(\.styleguide) private var styleguide
	
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
		}
	}
}


#Preview {
	VStack(spacing: 48) {
		EmptyDayView(date: .now, isExcluded: false)
		Divider()
		EmptyDayView(date: .now, isExcluded: true)
	}
	.styledPreview()
	.padding()
}
