//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 20.07.24.
//

import SwiftUI
import Utils
import TodoListDomain

public struct TodoContainerView: View {
	public init() { }
		
	@Environment(\.appNavigation) private var appNavigation
	
    public var body: some View {
		TodoPagingView()
	}
}


public extension EnvironmentValues {
	@Entry var todoRepository: TodoRepository = PreviewRepository()
	@Entry var todoListProvider: TodoListProvider = PreviewRepository()
}



#Preview("Pages") {
	TodoContainerView()
		.styledPreview()
}
