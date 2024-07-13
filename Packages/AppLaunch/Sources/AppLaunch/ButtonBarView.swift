//
//  SwiftUIView 2.swift
//  AppLaunch
//
//  Created by Benjamin Böcker on 13.07.24.
//

import SwiftUI
import SharedComponents

struct ButtonBarView: View {
	
	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings
	
	@Binding var showsAppInfo: Bool
	@Binding var showsNewTodo: Bool

	var body: some View {
		HStack(spacing: styleguide.large) {
			RoundedButton(image: "info") {
				showsAppInfo = true
			}
			
			RoundedButton(image: "arrow.up.right.and.arrow.down.left") {
				withAnimation(.snappy) {
					settings.isFocusedOnToday = true
				}
			}

			Spacer()
			
			RoundedButton(image: "plus") {
				
			}
		}
	}
}



#Preview {
	ButtonBarView(
		showsAppInfo: .constant(false),
		showsNewTodo: .constant(false)
	)
	.padding(.horizontal)
	.styledPreview()
}
