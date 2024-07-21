//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 20.07.24.
//

import SwiftUI
import Utils


public struct TodoContainerView: View {
	public init() { }
		
	@Environment(\.appNavigation) private var appNavigation
	
    public var body: some View {
		switch appNavigation.displayMode {
		case .list:
			TodoListView()
		case .pages:
			TodoPagingView()
		}
	}
}


#Preview("List") {
	TodoContainerView()
		.styledPreview()
}

#Preview("Pages") {
	TodoContainerView()
		.environment(\.appNavigation, .pages)
		.styledPreview()
}
