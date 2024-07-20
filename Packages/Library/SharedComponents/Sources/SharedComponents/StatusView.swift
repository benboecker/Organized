//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import SwiftUI
import Styleguide


public struct StatusView: View {
	public enum Status {
		case urgent, important, normal
	}
	
	public init(isDone: Binding<Bool>, status: Status) {
		self._isDone = isDone
		self.status = status
	}
	
	@Environment(\.styleguide) private var styleguide
	@Binding private var isDone: Bool
	private let status: Status
	
	public var body: some View {
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
		switch (isDone, status) {
		case (true, _): styleguide.secondaryText
		case (false, .normal): styleguide.primaryText
		case (false, .important): styleguide.accent
		case (false, .urgent): styleguide.accent
		}
	}

	private var symbolRenderingMode: SymbolRenderingMode {
		switch (isDone, status) {
		case (true, _): .monochrome
		case (false, .normal): .monochrome
		case (false, .important): .palette
		case (false, .urgent): .monochrome
		}
	}

	private var imageName: String {
		switch (isDone, status) {
		case (true, _): "checkmark.circle"
		case (false, .normal): "circle"
		case (false, .important): "exclamationmark.circle"
		case (false, .urgent): "exclamationmark.circle"
		}
	}
}


#Preview {
	@Previewable @State var isDone = false
	
	VStack(alignment: .leading, spacing: 24) {
		HStack {
			StatusView(isDone: $isDone, status: .normal)
			Text("Normal")
				.font(.headline)
		}
		HStack {
			StatusView(isDone: $isDone, status: .important)
			Text("Important")
				.font(.headline)
		}
		HStack {
			StatusView(isDone: $isDone, status: .urgent)
			Text("Overdue")
				.font(.headline)
		}
		HStack {
			StatusView(isDone: .constant(true), status: .normal)
			Text("Done")
				.font(.headline)
		}

	}
	.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	.padding()
	.styledPreview()
}
