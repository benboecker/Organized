//
//  SwiftUIView.swift
//  NewTodo
//
//  Created by Benjamin Böcker on 24.07.24.
//

import SwiftUI
import Styleguide
import SharedComponents
import NewTodoDomain
import Settings
import Utils


public struct NewNewTodoView: View {
	public init(date: Date) {
		print("New Todo on date: \(date.formatted(.dateTime.day().month()))")
		self.date = date
	}
	
	private let date: Date
	
	@State private var title: String = ""
	@State private var isImportant: Bool = false
	@State private var isDateSelected: Bool = true
	@State private var isLaterSelected: Bool = false

	@Environment(\.styleguide) private var styleguide
	@Environment(\.appNavigation) private var appNavigation
	@Environment(\.newTodoCreation) private var newTodoCreation

	public var body: some View {
		VStack(spacing: styleguide.large) {
			HStack {
				Text("Neue Aufgabe")
					.font(styleguide.largeTitle)
				Spacer()
				
#if os(macOS)
				Button {
					appNavigation.newTodoDate = nil
				} label: {
					Image(systemName: "xmark.circle.fill")
						.symbolRenderingMode(.palette)
						.foregroundStyle(styleguide.secondaryText, styleguide.secondaryBackground)
						.font(styleguide.largeTitle)
				}
#endif
			}
			
			VStack(spacing: styleguide.large) {
				TextField("New Todo", text: $title, axis: .vertical)
					.font(styleguide.body)
					.foregroundStyle(styleguide.primaryText)
					.padding(.horizontal, styleguide.large)
					.padding(.vertical, styleguide.medium)
					.background(
						styleguide.secondaryBackground,
						in: .rect(cornerRadius: styleguide.extraSmall)
					)
					.submitLabel(.done)
					.onSubmit {
						print("Goooooo \(title)")
						
						Task {
							try await newTodoCreation.createNewTodo(
								title: title,
								isImportant: isImportant,
								dueDate: isDateSelected ? date : nil
							)
						}
					}
				
				HStack(spacing: styleguide.large) {
					OrganizedToggle(imageName: "exclamationmark", isOn: $isImportant)
					
					HStack(spacing: styleguide.large) {
						OrganizedToggle(title: "\(date.formatted(.dateTime.day().month(.wide)))", isOn: $isDateSelected)
							.disabled(isDateSelected && !isImportant)
						
						OrganizedToggle(title: "Später", isOn: $isLaterSelected)
							.hidden(isImportant)
							.disabled(isLaterSelected)
					}

				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(styleguide.large)
		.background(
			styleguide.primaryBackground.shadow(.drop(color: .black.opacity(0.15), radius: styleguide.small, y: styleguide.small / 2)),
			in: .rect(cornerRadius: styleguide.medium)
		)
		.padding(styleguide.large)
		.onChange(of: isDateSelected) { _, newValue in
			isLaterSelected = !newValue
		}
		.onChange(of: isLaterSelected) { _, newValue in
			isDateSelected = !newValue
		}
    }
}

extension View {
	@ViewBuilder
	func hidden(_ isHidden: Bool) -> some View {
		if isHidden {
			self.hidden()
		} else {
			self
		}
	}
}


#Preview {
	NewNewTodoView(date: .now.addingTimeInterval(86400 * 50))
		.styledPreview()
}
