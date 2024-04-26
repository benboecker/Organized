//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.04.24.
//

import Foundation
import SwiftUI


@available(iOS 17.0, *)
struct AlertPreview: View {
	init(config: DisplayConfig = .init()) {
		self.config = config
	}
	
	let config: DisplayConfig
	
	@State private var showAlert1 = false
	@State private var showAlert2 = false
	
	var body: some View {
		Button("Show Alert") {
			showAlert1 = true
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				showAlert2 = true
			}
		}
		.buttonStyle(.borderedProminent)
		.alert(isPresented: $showAlert1, displayConfig: config) {
			RoundedRectangle(cornerRadius: 12)
				.fill(.red.gradient)
				.frame(width: 150, height: 150)
				.shadow(color: .black.opacity(0.15), radius: 8, y: 4.0)
				.overlay {
					Button("Dismiss") {
						showAlert1 = false
					}
					.buttonStyle(.borderedProminent)
				}
				.alert(isPresented: $showAlert2, displayConfig: config) {
					RoundedRectangle(cornerRadius: 12)
						.fill(.green.gradient)
						.frame(width: 150, height: 150)
						.shadow(color: .black.opacity(0.15), radius: 8, y: 4.0)
				}
		}
	}
}

#Preview {
	AlertPreview()
}

#Preview {
	AlertPreview(config: .nonBlurred)
}
