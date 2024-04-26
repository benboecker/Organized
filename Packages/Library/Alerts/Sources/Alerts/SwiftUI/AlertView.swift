//
//  AlertView.swift
//  AlertTest
//
//  Created by Benjamin Böcker on 02.04.24.
//

import Foundation
import SwiftUI




@available(iOS 17.0, *)
struct AlertView<Content: View>: View {
	
	let displayConfig: DisplayConfig
	
	@Binding var alertPresented: Bool
	@ViewBuilder var content: () -> Content
	@State private var displayContent = false

	var body: some View {
		ZStack {
			ZStack {
				if displayConfig.enableBackgroundBlur {
					Rectangle()
						.fill(.ultraThinMaterial)
				} else {
					Rectangle()
						.fill(.primary.opacity(0.5))
				}
			}
			.ignoresSafeArea()
			.contentShape(.rect)
			.onTapGesture {
				guard !displayConfig.disableOutsideTap else { return }
				
				alertPresented = false
				withAnimation(.snappy(duration: displayConfig.durationOut, extraBounce: 0)) {
					displayContent = false
				}
			}
			.opacity(displayContent ? 1.0 : 0.0)
			
			if displayContent && displayConfig.transitionType == .slide {
				content()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.move(edge: displayConfig.slideEdge))
					.zIndex(1000)
			} else {
				content()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.opacity(displayContent ? 1.0 : 0.0)
					.zIndex(1000)
			}
		}
		.onAppear {
			withAnimation(.snappy(duration: displayConfig.durationIn, extraBounce: 0)) {
				displayContent = true
			}
		}
		.onChange(of: alertPresented) { oldValue, newValue in
			guard !alertPresented else { return }
			withAnimation(.snappy(duration: displayConfig.durationOut, extraBounce: 0)) {
				displayContent = false
			}
		}
	}
}


//#Preview {
//	if #available(iOS 17.0, *) {
//		AlertPreview()
//	} else {
//		EmptyView()
//	}
//}
