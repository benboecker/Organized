//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.04.24.
//

import Foundation
import SwiftUI
import SharedComponents
import TodoListDomain


struct TodoRow: View {
	init(title: String, isDone: Bool, isImportant: Bool, repository: TodoRepository) {
		self._title = State(initialValue: title)
		self._isDone = State(initialValue: isDone)
		self._isImportant = State(initialValue: isImportant)
		self.repository = repository
	}
	
	@State private var title: String
	@State private var isDone: Bool
	@State private var isImportant: Bool
	private let repository: TodoRepository
	
	var body: some View {
		HStack(spacing: 4) {
			StatusView(isDone: $isDone, isImportant: $isImportant)
			
			TextField("", text: $title, axis: .vertical)
				.fontStyle(.body)
				.color(foreground: isDone ? .secondaryText : .primaryText)
				.submitLabel(.done)
				.strikethrough(isDone, color: .secondary)
		}
	}
}


#Preview {
	VStack(spacing: 32) {
		TodoRow(title: "This is an example title", isDone: false, isImportant: false, repository: PreviewRepository())
		TodoRow(title: "This is an example title", isDone: false, isImportant: true, repository: PreviewRepository())
		TodoRow(title: "This is an example title", isDone: true, isImportant: false, repository: PreviewRepository())
	}
	.padding(8)
}
