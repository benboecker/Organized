//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import SharedComponents



struct StatusView: View {
	init(isDone: Binding<Bool>, isImportant: Binding<Bool>) {
		self._isDone = isDone
		self._isImportant = isImportant
	}
	
	@Binding private var isDone: Bool
	@Binding private var isImportant: Bool

	var body: some View {
		if isDone {
			Button {
				withAnimation(.snappy) {
					isDone = false
				}
			} label: {
				Image(systemName: imageName)
					.font(.title2)
					.symbolRenderingMode(symbolRenderingMode)
					.foregroundStyle(foregroundStyle, .primary)
					.frame(minWidth: 44, minHeight: 44)
			}
		} else {
			Menu {
				Button {
					withAnimation(.snappy) {
						isImportant.toggle()
					}
				} label: {
					Label(isImportant ? "Nicht wichtig" : "Wichtig", systemImage: isImportant ? "circle" : "exclamationmark.circle")
				}
			} label: {
				Image(systemName: imageName)
					.font(.title2)
					.symbolRenderingMode(symbolRenderingMode)
					.foregroundStyle(foregroundStyle, Color.primary)
					.frame(minWidth: 44, minHeight: 44)
			} primaryAction: {
				withAnimation(.snappy) {
					isDone = true
				}
			}
		}
    }

	private var foregroundStyle: Color {
		switch (isDone, isImportant) {
		case (true, _): .secondary
		case (false, true): .red
		case (false, false): .primary
		}
	}

	private var symbolRenderingMode: SymbolRenderingMode {
		switch (isDone, isImportant) {
		case (true, _): .monochrome
		case (false, true): .palette
		case (false, false): .monochrome
		}
	}

	private var imageName: String {
		switch (isDone, isImportant) {
		case (true, _): "checkmark.circle"
		case (false, true): "exclamationmark.circle"
		case (false, false): "circle"
		}
	}
}

private struct StatusPreview: View {
	init(isDone: Bool, isImportant: Bool) {
		self._isDone = State(initialValue: isDone)
		self._isImportant = State(initialValue: isImportant)
	}

	@State private var isDone: Bool
	@State private var isImportant: Bool

	var body: some View {
		StatusView(isDone: $isDone, isImportant: $isImportant)
	}
}

#Preview {
	VStack(spacing: 24) {
		StatusPreview(isDone: false, isImportant: false)
			.debugFrame(showSize: false)
		StatusPreview(isDone: false, isImportant: true)
			.debugFrame(showSize: false)
		StatusPreview(isDone: true, isImportant: true)
			.debugFrame(showSize: false)
	}
	.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	.padding()
}
