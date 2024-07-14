//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 23.04.24.
//

import SwiftUI
import TodoListDomain
import Utils
import Styleguide
import SharedComponents


public struct TodoListView: View {
	public init(
		statusBarOpacity: Binding<Double>,
		showNewTodo: @escaping (Date) -> Void,
		showSettings: @escaping () -> Void
	) {
		self._statusbarOpacity = statusBarOpacity
		self.showNewTodo = showNewTodo
		self.showSettings = showSettings
	}
	
	private let showNewTodo: (Date) -> Void
	private let showSettings: () -> Void
	
	@Environment(\.todoRepository) private var todoRepository
	@Environment(\.todoListProvider) private var todoListProvider
	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings
	@FocusState private var focusedTodoID: UUID?
	@Binding private var statusbarOpacity: Double
	@Namespace private var animation
	
	public var body: some View {
		if settings.isFocusedOnToday, let section = todoListProvider.sections.first {
			TodayView(
				section: section,
				focusedID: $focusedTodoID,
				animation: animation
			)
				.padding(.horizontal, styleguide.large)
		} else {
			ScrollView {
				LazyVStack(spacing: styleguide.large) {
					HStack(spacing: styleguide.large) {
						PillButton(title: "App Info", imageName: "info.circle") {
							
						}

						PillButton(title: "Nur Heute", imageName: "arrow.up.right.and.arrow.down.left") {
							withAnimation(.snappy) {
								settings.isFocusedOnToday = true
							}
						}
						
						Spacer()
					}
					.padding(.bottom, styleguide.extraLarge)
					
					ForEach(todoListProvider.sections) { section in
						TodoSectionView(
							section: section,
							focusedID: $focusedTodoID,
							animation: animation
						)
						
						if todoListProvider.sections.last != section {
							Divider()
								.padding(.bottom, styleguide.extraLarge)
						}
					}
				}
				.animation(.snappy, value: todoListProvider.sections)
				.padding(.horizontal, styleguide.large)
				.padding(.leading, styleguide.extraSmall)
				.padding(.vertical, styleguide.extraLarge)
			}
			.onScrollGeometryChange(for: ScrollValues.self) { geo in
				ScrollValues(
					offset: geo.contentOffset.y,
					inset: geo.contentInsets.top
				)
			} action: { oldValue, newValue in
				let newOpacity = 1 + ((newValue.offset) / (newValue.inset))
				
				if statusbarOpacity > 0.0 && newOpacity < 0.0 {
					statusbarOpacity = 0.0
				} else if statusbarOpacity < 1.0 && newOpacity > 1.0 {
					statusbarOpacity = 1.0
				} else if newOpacity >= 0.0 && newOpacity <= 1.0 {
					statusbarOpacity = newOpacity
				}
			}
		}
	}
	
	@ViewBuilder
	func TodoContextMenu(id: UUID, priority: Todo.Priority) -> some View {
		if priority == .normal {
			Button {
				todoRepository.update(isImportant: true, of: id)
			} label: {
				Label("Wichtig", systemImage: "exclamationmark.circle")
			}
		} else if priority == .important {
			Button {
				todoRepository.update(isImportant: false, of: id)
			} label: {
				Label("Nicht wichtig", systemImage: "circle")
			}
		}
		
		Button {
			
		} label: {
			Label("Fällig am", systemImage: "calendar")
		}
		
		Divider()
		
		Button(role: .destructive) {
			
		} label: {
			Label("Löschen", systemImage: "trash")
		}
	}
	
//	func ToolbarItems() -> some ToolbarContent {
//		ToolbarItemGroup(placement: .keyboard) {
//			Button {
//				if let focussedTodoID {
//					self.focussedTodoID = todoListProvider.id(before: focussedTodoID)
//				}
//			} label: {
//				Label("Zurück", systemImage: "arrow.up")
//			}
//			.tint(styleguide.primaryText)
//			
//			Color.clear.frame(width: 10)
//			
//			Button {
//				if let focussedTodoID {
//					self.focussedTodoID = todoListProvider.id(after: focussedTodoID)
//				}
//			} label: {
//				Label("Weiter", systemImage: "arrow.down")
//					.padding(.leading, 10)
//			}
//			.tint(styleguide.primaryText)
//
//			Spacer()
//			
//			Button {
//				UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//			} label: {
//				Label("Fertig", systemImage: "keyboard.chevron.compact.down")
//			}
//			.tint(styleguide.primaryText)
//		}
		
	//}
	
	struct ScrollValues: Equatable {
		let offset: Double
		let inset: Double
	}
}

#Preview {
	TodoListView(statusBarOpacity: .constant(0.0)) { _ in } showSettings: { }
		.styledPreview()
}

#Preview {
	TodoListView(statusBarOpacity: .constant(0.0)) { _ in } showSettings: { }
		.styledPreview()
}



public extension EnvironmentValues {
	@Entry var todoRepository: TodoRepository = PreviewRepository()
	@Entry var todoListProvider: TodoListProvider = PreviewRepository()
}

