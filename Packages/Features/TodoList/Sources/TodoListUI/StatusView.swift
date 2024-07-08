//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import SharedComponents
import TodoListDomain
import Styleguide


struct StatusView: View {
	init(isDone: Binding<Bool>, priority: Todo.Priority) {
		self._isDone = isDone
		self.priority = priority
	}
	
	@Environment(\.styleguide) private var styleguide
	@Binding private var isDone: Bool
	private let priority: Todo.Priority

	var body: some View {
		Button {
			withAnimation(.snappy) {
				isDone.toggle()
			}
		} label: {
			Image(systemName: imageName)
				.font(.title2)
				.symbolRenderingMode(symbolRenderingMode)
				.foregroundStyle(foregroundStyle, styleguide.primaryText)
//				.frame(minWidth: 44, minHeight: 44)
		}
    }

	private var foregroundStyle: Color {
		switch (isDone, priority) {
		case (true, _): styleguide.secondaryText
		case (false, .normal): styleguide.primaryText
		case (false, .important): styleguide.accent
		case (false, .overdue): styleguide.accent
		}
	}

	private var symbolRenderingMode: SymbolRenderingMode {
		switch (isDone, priority) {
		case (true, _): .monochrome
		case (false, .normal): .monochrome
		case (false, .important): .palette
		case (false, .overdue): .monochrome
		}
	}

	private var imageName: String {
		switch (isDone, priority) {
		case (true, _): "checkmark.circle"
		case (false, .normal): "circle"
		case (false, .important): "exclamationmark.circle"
		case (false, .overdue): "exclamationmark.circle"
		}
	}
}

private struct StatusPreview: View {
	init(isDone: Bool, priority: Todo.Priority) {
		self._isDone = State(initialValue: isDone)
		self.priority = priority
	}

	@State private var isDone: Bool
	private let priority: Todo.Priority

	var body: some View {
		StatusView(isDone: $isDone, priority: priority)
	}
}

#Preview {
	VStack(alignment: .leading, spacing: 24) {
		HStack {
			StatusPreview(isDone: false, priority: .normal)
			Text("Normal")
				.font(.headline)
		}
		HStack {
			StatusPreview(isDone: false, priority: .important)
			Text("Important")
				.font(.headline)
		}
		HStack {
			StatusPreview(isDone: false, priority: .overdue)
			Text("Overdue")
				.font(.headline)
		}
		HStack {
			StatusPreview(isDone: true, priority: .normal)
			Text("Done")
				.font(.headline)
		}

	}
	.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	.padding()
	.styledPreview()
}
