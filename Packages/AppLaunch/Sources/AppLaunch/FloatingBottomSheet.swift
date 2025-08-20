//
//  SwiftUIView.swift
//  SharedComponents
//
//  Created by Benjamin Böcker on 20.08.24.
//

import SwiftUI
import Utils
import AppInfoUI
import OnboardingUI
import OnboardingDomain




struct FloatingBottomSheetModifier<SheetContent: View>: ViewModifier {
	init(
		isPresented: Binding<Bool>,
		onDismiss: @escaping () -> Void,
		@ViewBuilder sheetContent: () -> SheetContent
	) {
		self._isPresented = isPresented
		self.onDismiss = onDismiss
		self.sheetContent = sheetContent()
	}
	
	@Binding private var isPresented: Bool
	private let onDismiss: () -> Void
	private let sheetContent: SheetContent
	
	@State private var sheetHeight: CGFloat = .zero
	
	func body(content: Content) -> some View {
		content
			.sheet(isPresented: $isPresented, onDismiss: onDismiss) {
				sheetContent
					.frame(maxWidth: .infinity)
					.padding()
					.background(.background, in: .rect(cornerRadius: 15))
				//				.shadow(color: .black.opacity(0.15), radius: 8)
					.padding(.horizontal)
					.overlay {
						GeometryReader { geometry in
							Color.clear.preference(key: SheetHeightPreferenceKey.self, value: geometry.size.height)
						}
					}
					.onPreferenceChange(SheetHeightPreferenceKey.self) { newHeight in
						sheetHeight = newHeight
					}
					.presentationDetents([.height(sheetHeight)])
					.presentationCornerRadius(0)
					.presentationBackground(.clear)
					.presentationDragIndicator(.hidden)
			}
	}
}

struct SheetHeightPreferenceKey: PreferenceKey {
	static let defaultValue: CGFloat = .zero
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}



extension View {
	
	@ViewBuilder
	func floatingBottomSheet<Content: View>(
		isPresented: Binding<Bool>,
		onDismiss: @escaping () -> () = { },
		@ViewBuilder content: @escaping () -> Content
	) -> some View {
		self.modifier(FloatingBottomSheetModifier(isPresented: isPresented, onDismiss: onDismiss, sheetContent: content))
	}
}


struct TestView: View {
	
	@State private var showSheet = false
	
	
	var body: some View {
		Button("Show Sheet") {
			showSheet.toggle()
		}
		.floatingBottomSheet(isPresented: $showSheet) {
			TestSheet()
		}
	}
}


struct TestSheet: View {
	@Environment(\.dismiss) private var dismiss
	@State var text = ""
	@State var grow = false
	
	var body: some View {
		VStack(spacing: 12) {
			Text("This is a test sheet!")
				.font(.title.bold())
			TextField("Oh oh", text: $text, axis: .vertical)
				.frame(minHeight: 100)
			if grow {
				Text("MAKE ME BIGGER!!!")
					.padding(.vertical, 100)
			}
			
			Button("GROW") {
				withAnimation(.snappy) {
					grow.toggle()
				}
			}
			
			Image(systemName: "figure.2")
				.font(.largeTitle.bold())
				.foregroundStyle(Color.accentColor)
			
			Button("Dismiss") {
				dismiss()
			}
			.buttonStyle(.borderedProminent)
		}
	}
}


#Preview {
	TestView()
}
