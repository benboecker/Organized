//
//  SwiftUIView 2.swift
//  AppLaunch
//
//  Created by Benjamin Böcker on 20.07.24.
//

import SwiftUI
import Styleguide
import SharedComponents



struct BottomButtonBar: View {
	
	@Environment(\.styleguide) private var styleguide
	
	var body: some View {
		HStack(spacing: styleguide.medium) {
			OrganizedButton(title: nil, imageName: "info") {
				
			}
			OrganizedButton(title: nil, imageName: "arrow.up.right.and.arrow.down.left") {
				
			}
			Spacer()
			OrganizedButton(title: "Neue Aufgabe", imageName: "plus") {
				
			}
		}
		.padding(.top, styleguide.large)
		.padding(.horizontal, styleguide.large)
		.background(styleguide.primaryBackground.shadow(.drop(color: .black.opacity(0.15), radius: 6)))
		
	}
}


#Preview {
	ZStack(alignment: .bottom) {
		BottomButtonBar()
	}
	.frame(maxHeight: .infinity, alignment: .bottom)
	.styledPreview()
}
