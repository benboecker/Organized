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
	@State var isExpanded: Bool = false
	let newTodo: (Date) -> Void
	
	@Environment(\.styleguide) private var styleguide
	@Environment(\.todoListProvider) private var todoListProvider
	@Environment(\.settings) private var settings

    var body: some View {
		VStack(spacing: styleguide.large) {
			Button {
				withAnimation(.snappy) {
					isExpanded.toggle()
				}
			} label: {
				HStack(spacing: styleguide.medium) {
					WeekdayView(date: date)
					
					Image(systemName: "chevron.\(isExpanded ? "up" : "down").circle.fill")
						.font(.headline)
						.symbolRenderingMode(.hierarchical)
						.foregroundStyle(styleguide.secondaryText)
						.padding(.leading, 4)
					Spacer()
				}
			}
			
			if isExpanded {
				OrganizedButton(title: "Neue Aufgabe", imageName: "plus") {
					newTodo(date)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				
				OrganizedButton(title: "Tag ausschließen", imageName: "calendar.badge.minus") {
					withAnimation(.snappy) {
						settings.toggleManuallyExclude(date: date)
						todoListProvider.regenerate()
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
    }
}

#Preview {
	@Previewable @State var isExpanded = false
	WeekdayHeaderView(
		date: .now
	) { _ in }
		.padding()
		.styledPreview()
}
