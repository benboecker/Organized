//
//  SwiftUIView.swift
//  Onboarding
//
//  Created by Benjamin Böcker on 16.07.24.
//

import SwiftUI
import Styleguide
import Settings
import OnboardingDomain
import SharedComponents


struct ThirdPageView: View {

	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings

    var body: some View {
		VStack {
			
			OrganizedButton(
				title: "Starten",
				imageName: "checkmark"
			) {
				settings.showOnboarding = false
			}
		}
	}
}

#Preview {
	ThirdPageView()
		.styledPreview()
}
