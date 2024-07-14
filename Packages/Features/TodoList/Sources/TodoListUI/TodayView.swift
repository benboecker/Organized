//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Benjamin Böcker on 13.07.24.
//

import SwiftUI
import Styleguide
import Settings
import SharedComponents
import TodoListDomain


struct TodayView: View {
	let section: TodoSection
	var focusedID: FocusState<Todo.ID?>.Binding
	let animation: Namespace.ID
	
	@Environment(\.settings) private var settings
	@Environment(\.styleguide) private var styleguide
	
    var body: some View {
		VStack(spacing: styleguide.large) {
			Spacer()
			TodoSectionView(
				section: section,
				focusedID: focusedID,
				animation: animation
			)
			Spacer()
			
			PillButton(title: "Alle Aufgaben", imageName: "arrow.down.backward.and.arrow.up.forward") {
				withAnimation(.snappy) {
					settings.isFocusedOnToday = false
					
				}
			}
		}
    }
}
//
//#Preview {
//	TodayView()
//}
