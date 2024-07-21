//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 20.07.24.
//

import SwiftUI


public struct TodoContainerView: View {
	public enum DisplayMode {
		case list
		case focused
	}
	
	public init(statusBarOpacity: Binding<Double>, displayMode: DisplayMode) {
		self._statusbarOpacity = statusBarOpacity
		self.displayMode = displayMode
	}
	
	private let displayMode: DisplayMode
	@Binding private var statusbarOpacity: Double	
	
	
    public var body: some View {
//		switch displayMode {
//		case .list:
//			TodoListView(showNewTodo: { _ in }, showSettings: { })
//		case .focused:
			TodoPagingView()
//		}
	}
}


#Preview("Focused") {
	TodoContainerView(statusBarOpacity: .constant(0), displayMode: .focused)
		.styledPreview()
}

#Preview("List") {
	TodoContainerView(statusBarOpacity: .constant(0), displayMode: .list)
		.styledPreview()
}
