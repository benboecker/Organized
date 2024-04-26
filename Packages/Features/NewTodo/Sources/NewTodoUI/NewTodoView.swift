//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 25.04.24.
//

import SwiftUI
import Styleguide
import SharedComponents
import NewTodoDomain


public struct NewTodoView: View {
	public init(newTodoCreation: NewTodoCreation) {
		self.newTodoCreation = newTodoCreation
	}
	
	enum Screen {
		case dateSelection
	}
	
	let newTodoCreation: NewTodoCreation
	
	@State private var path: [Screen] = []
	@State private var title: String = ""
	@State private var isImportant: Bool = false
	@State private var hasDateSelected: Bool = false
	@State private var selectedDate: Date = .now
	
	@Environment(\.dismiss) private var dismiss
	
	public var body: some View {
		NavigationStack(path: $path) {
			Content()
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .cancellationAction) {
						Button {
							dismiss()
						} label: {
							Image(systemName: "xmark.circle.fill")
								.font(.title3.bold())
								.symbolRenderingMode(.hierarchical)
								.foregroundStyle(Color.secondary)
						}
					}
				}
				.navigationTitle("Neue Aufgabe")
				.navigationDestination(for: NewTodoView.Screen.self) { selection in
					if selection == .dateSelection {
						DateSelection(selectedDate: $selectedDate)
					}
				}
		}
		.presentationDetents([.medium, .large])
	}
}

private extension NewTodoView {
	func Content() -> some View {
		VStack(spacing: 24) {
			TextField("New Todo", text: $title, axis: .vertical)
				.fontStyle(.body)
				.color(foreground: .primaryText)
				.padding(.horizontal, 12)
				.padding(.vertical, 8)
				.background(
					Color.secondary.quinary,
					in: .rect(cornerRadius: 4)
				)
				.submitLabel(.done)
			
			HStack(spacing: 16) {
				IsImportantButton()
				Text("Wichtig")
					.body()
				Spacer()
			}
						
			HStack(spacing: 16) {
				ShowDateSelectionButton()
				
				Button {
					hasDateSelected = true
					path.append(.dateSelection)
				} label: {
					Text(hasDateSelected ? "Due Date:" : "Select due date")
						.body()
					
					if hasDateSelected {
						Text(selectedDate, format: .dateTime.day().month(.wide).year())
							.fontStyle(.headline)
							.color(foreground: .primaryText)
					}
				}
				
				Spacer()
			}
			
			Button {
				Task { @MainActor in
					do {
						try await newTodoCreation.createNewTodo(
							title: title,
							isImportant: isImportant,
							dueDate: hasDateSelected ? selectedDate : nil
						)
						
						dismiss()
					} catch {
						fatalError("\(error)")
					}
				}
			} label: {
				Label("Speichern", systemImage: "checkmark")
					.padding(.horizontal, 16)
					.padding(.vertical, 6)
					.fontStyle(.body)
					.color(foreground: .primaryText)
					.background(
						.thinMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 2, y: 2)),
						in: .capsule)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.padding(.horizontal)
			}
			
			Spacer()
		}
		.padding(.horizontal)
		.onChange(of: selectedDate) { _, _ in
			path.removeAll()
		}
	}
	
	func IsImportantButton() -> some View {
		Button {
			withAnimation(.snappy) {
				isImportant.toggle()
			}
		} label: {
			Image(systemName: "exclamationmark")
				.font(.system(.headline, design: .rounded, weight: .heavy))
				.color(foreground: isImportant ? .accent : .secondaryText)
				.padding(8)
				.frame(minWidth: 36, minHeight: 28)
				.background(
					.thinMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 2, y: 2)),
					in: .circle
				)
		}
	}
	
	func ShowDateSelectionButton() -> some View {
		Button {
			withAnimation(.snappy) {
				hasDateSelected.toggle()
			}
			
			if hasDateSelected {
				path.append(.dateSelection)
			}
		} label: {
			Image(systemName: "checkmark")
				.font(.system(.headline, design: .rounded, weight: .heavy))
				.color(foreground: hasDateSelected ? .primaryText : .secondaryBackground)
				.padding(8)
				.frame(minWidth: 36, minHeight: 28)
				.background(
					.thinMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 2, y: 2)),
					in: .circle
				)
		}
	}
}



#Preview {
	NewTodoView(newTodoCreation: PreviewTodoCreation())
}

class PreviewTodoCreation: NewTodoCreation {
	func createNewTodo(title: String, isImportant: Bool, dueDate: Date?) async throws { }
}
