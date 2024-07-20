//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 20.07.24.
//

import SwiftUI
import TodoListDomain
import Utils
import Styleguide
import SharedComponents
import SwiftUITools



struct TodoPagingView: View {
	
	@Environment(\.todoRepository) private var todoRepository
	@Environment(\.todoListProvider) private var todoListProvider
	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings
	
	@FocusState private var focusedTodoID: UUID?
	@Namespace private var animation
	@State private var selectedWeekdayIndex: Int? = nil
	
	var body: some View {
		VStack {
			Spacer()
			ScrollView(.horizontal) {
				LazyHStack(spacing: 0) {
					ForEach(todoListProvider.sections) { section in
						VStack(spacing: styleguide.large) {
							TodoSectionView(
								section: section,
								focusedID: $focusedTodoID,
								animation: animation
							)
						}
						.padding(.horizontal, styleguide.extraLarge)
						.containerRelativeFrame(.horizontal)
						.id(todoListProvider.sections.map(\.id).firstIndex(of: section.id))
					}
				}
				.scrollTargetLayout()
			}
			.scrollPosition(id: $selectedWeekdayIndex)
			.scrollIndicators(.hidden)
			.scrollTargetBehavior(.paging)
			Spacer()
			
			if todoListProvider.sections.count > 1 {
				PageIndicatorView(
					numberOfPages: todoListProvider.sections.count,
					currentPage: $selectedWeekdayIndex
				)
				.pageIndicatorTintColor(styleguide.secondaryText)
				.currentPageIndicatorTintColor(styleguide.primaryText)
				Spacer()
			}
		}
	}
}

#Preview {
	TodoPagingView()
		.styledPreview()
}
