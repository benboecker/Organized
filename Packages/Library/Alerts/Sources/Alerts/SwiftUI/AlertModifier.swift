//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.04.24.
//

import Foundation
import SwiftUI



@available(iOS 17.0, *)
public extension View {
	func alert<Content: View>(
		isPresented alertPresented: Binding<Bool>,
		displayConfig: DisplayConfig = .init(),
		@ViewBuilder content: @escaping () -> Content
	) -> some View {
		self.modifier(AlertModifier(
			alertContent: content,
			alertPresented: alertPresented,
			displayConfig: displayConfig
		))
	}
}


@available(iOS 17.0, *)
struct AlertModifier<AlertContent: View>: ViewModifier {
	@ViewBuilder var alertContent: () -> AlertContent
	@Binding var alertPresented: Bool
	let displayConfig: DisplayConfig
	
	func body(content: Content) -> some View {
		content
			.onChange(of: alertPresented, initial: false) { _, _ in
				if alertPresented {
					AlertManager.shared.presentAlert(
						alertPresented: $alertPresented,
						displayConfig: displayConfig,
						content: alertContent
					)
				} else {
					AlertManager.shared.dismissAlert(displayConfig: displayConfig)
				}
			}
	}
	
}


#Preview {
	AlertPreview()
}
