//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 13.07.24.
//

import SwiftUI
import TodoListDomain
import SharedComponents
import Styleguide
import Settings


struct TodoSectionView: View {
	
	let section: TodoSection
	@Environment(\.settings) private var settings
	@Environment(\.styleguide) private var styleguide
	var focusedID: FocusState<Todo.ID?>.Binding
		
    var body: some View {
		Section {
			if section.todos.isEmpty {
				EmptyDayView(date: section.date, isManuallyExcluded: section.isManuallyExcluded)
					.padding(.bottom, styleguide.extraLarge)
			} else {
				ForEach(section.todos) { todo in
					TodoRow(todo: todo, focussed: focusedID)
				}
			}
		} header: {
			if section.todos.hasContent {
				WeekdayView(date: section.date)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.leading, 42)
			}
		}
    }
}

#Preview {
	@Previewable @FocusState var id: UUID?
	TodoSectionView(section: .preview, focusedID: $id)
		.padding(.horizontal)
		.padding(.vertical, 4)
		.styledPreview()
}
