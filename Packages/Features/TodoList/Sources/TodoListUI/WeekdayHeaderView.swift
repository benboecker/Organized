//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import TodoListDomain
import Styleguide
import SharedComponents
import Settings


struct WeekdayHeaderView: View {
	let date: Date
	let newTodo: (Date) -> Void
	
	@Environment(\.styleguide) private var styleguide
	@Environment(\.weekdayProvider) private var weekdayProvider
	@Environment(\.excludedDates) private var excludedDates

    var body: some View {
		Menu {
			Button {
				withAnimation(.snappy) {
					excludedDates.toggleManuallyExclude(date: date)
				}
			} label: {
				Label("Tag überspringen", systemImage: "calendar.badge.minus")
			}
			
			Button {
				newTodo(date)
			} label: {
				Label("Neue Aufgabe", systemImage: "plus.circle.fill")
			}
		} label: {
			HStack {
				WeekdayView(date: date)
				
				Image(systemName: "ellipsis.circle.fill")
					.font(.headline)
					.symbolRenderingMode(.hierarchical)
					.foregroundStyle(styleguide.secondaryText)
					.padding(.leading, 4)
				Spacer()
			}
		}
    }
}

#Preview {
	WeekdayHeaderView(
		date: .now
	) { _ in }
		.padding()
		.styledPreview()
}

#Preview {
	TodoListView { _ in }
		.styledPreview()
}

