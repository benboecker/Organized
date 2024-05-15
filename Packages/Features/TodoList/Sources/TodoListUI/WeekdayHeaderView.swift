//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import TodoListDomain
import Styleguide


struct WeekdayHeaderView: View {
	let date: Date
	let weekdayProvider: TodoListProvider
	let isExcluded: Bool
	let newTodo: (Date) -> Void
	
	@Environment(\.styleguide) private var styleguide
	
    var body: some View {
		Menu {
			Button {
				weekdayProvider.toggleDateExcluded(date)
			} label: {
				Label(isExcluded ? "Tag planen" : "Tag überspringen", systemImage: "calendar.badge.minus")
			}
			
			if !isExcluded {
				Button {
					newTodo(date)
				} label: {
					Label("Neue Aufgabe", systemImage: "plus.circle.fill")
				}
			}
		} label: {
			HStack {
				Text(date, format: .dateTime.weekday(.wide))
					.font(styleguide[\.title])
					.foregroundStyle(styleguide[\.primaryText])
				
				Text(date, format: .dateTime.day().month(.wide))
					.font(styleguide[\.title])
					.foregroundStyle(styleguide[\.secondaryText])
				
				Image(systemName: "ellipsis.circle.fill")
					.font(.headline)
					.symbolRenderingMode(.hierarchical)
					.foregroundStyle(styleguide[\.secondaryText])
					.padding(.leading, 4)
				Spacer()
			}
		}
    }
}

#Preview {
	WeekdayHeaderView(
		date: .now,
		weekdayProvider: PreviewRepository(),
		isExcluded: true
	) { _ in }
		.padding()
}

#Preview {
	WeekdayHeaderView(
		date: .now,
		weekdayProvider: PreviewRepository(),
		isExcluded: false
	) { _ in }
		.padding()
}

#Preview {
	TodoListView(
		todoRepository: PreviewRepository(),
		weekdayProvider: PreviewRepository()
	) { _ in }
}

