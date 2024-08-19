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
	@Environment(\.appNavigation) private var appNavigation

	@FocusState private var focusedTodoID: UUID?
	@State private var selectedWeekdayIndex: Int? = nil
	
	var body: some View {
		VStack {
			Spacer()
			PagingView()
			Spacer()
		}
		.overlay(alignment: .bottom) {			
			BottomBar()
		}
		.onAppear {
			selectedWeekdayIndex = todoListProvider.sections.hasContent ? 0 : nil
		}
	}
	
	private func PagingView() -> some View {
		ScrollView(.horizontal) {
			LazyHStack(spacing: 0) {
				ForEach(todoListProvider.sections) { section in
					VStack(spacing: styleguide.large) {
						TodoSectionView(
							section: section,
							focusedID: $focusedTodoID
						)
					}
					.padding(.horizontal, styleguide.large)
					.containerRelativeFrame(.horizontal)
					.id(todoListProvider.sections.map(\.id).firstIndex(of: section.id))
				}
			}
			.scrollTargetLayout()
		}
		.scrollPosition(id: $selectedWeekdayIndex)
		.scrollIndicators(.hidden)
		.scrollTargetBehavior(.paging)
		.animation(.snappy, value: selectedWeekdayIndex)
	}
	
	private func BottomBar() -> some View {
		HStack(alignment: .bottom, spacing: styleguide.medium) {
			OrganizedButton(imageName: "info") {
				appNavigation.showsAppInfo = true
			}

			if todoListProvider.sections.count > 1 {
				PageIndicatorView(
					numberOfPages: todoListProvider.sections.count,
					currentPage: $selectedWeekdayIndex
				)
				.pageIndicatorTintColor(styleguide.secondaryText)
				.currentPageIndicatorTintColor(styleguide.primaryText)
				.symbol { index in
					if todoListProvider.sections[index].todos.isEmpty {
						return "beach.umbrella.fill"
					} else {
						return nil
					}
				}
			} else {
				Spacer()
			}
			
			VStack(alignment: .trailing, spacing: styleguide.medium) {
				OrganizedButton(imageName: "calendar.badge.minus") {
					excludeSelectedDate()
				}
				.opacity(isExcludeButtonVisible ? 1.0 : 0.0)
				.animation(.snappy, value: isExcludeButtonVisible)
				
				OrganizedButton(imageName: "plus") {
					appNavigation.newTodoDate = selectedSection?.date
				}
			}
		}
		.padding(.horizontal, styleguide.large)
	}
	
	private var isExcludeButtonVisible: Bool {
		selectedSection?.todos.hasContent == true
	}
	
	private func excludeSelectedDate() {
		guard let selectedDate = selectedSection?.date else { return }
		
		withAnimation(.snappy) {
			settings.toggleManuallyExclude(date: selectedDate)
			todoListProvider.regenerate()
		}
	}
	
	private var selectedSection: TodoSection? {
		guard let selectedWeekdayIndex else { return nil }
		return todoListProvider.sections[selectedWeekdayIndex]
	}
}

#Preview {
	TodoPagingView()
		.styledPreview()
}
