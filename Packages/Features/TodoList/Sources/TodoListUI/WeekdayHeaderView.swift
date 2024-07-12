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
	@Environment(\.todoListProvider) private var todoListProvider
	
	
    var body: some View {
		Menu {
			Button {
				withAnimation(.snappy) {
					ExcludedDates.shared.toggleManuallyExclude(date: date)
					todoListProvider.regenerate()
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
	TodoListView(statusBarOpacity: .constant(0.0)) { _ in } showSettings: { }
		.styledPreview()
}

