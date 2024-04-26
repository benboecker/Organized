//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI



struct WeekdayHeaderView: View {
	let date: Date
	
    var body: some View {
		HStack {
			Text(date, format: .dateTime.weekday(.wide))
				.title()

			Text(date, format: .dateTime.day().month(.wide))
				.fontStyle(.title)
				.color(foreground: .secondaryText)
				.frame(maxWidth: .infinity, alignment: .leading)

		}
//		.overlay(alignment: .bottom) {
//			Rectangle()
//				.frame(height: 1.5)
//				.color(foreground: .secondaryText)
//				.offset(y: 6)
//		}
    }
}

#Preview {
	WeekdayHeaderView(date: .now)
		.padding()
}

#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	)
}

