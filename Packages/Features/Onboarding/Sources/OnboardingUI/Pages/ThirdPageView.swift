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
import Utils


struct ThirdPageView: View {

	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings
	@Environment(\.appNavigation) private var appNavigation
    var body: some View {
		VStack {
			
			OrganizedButton(
				title: "Starten",
				imageName: "checkmark"
			) {
				settings.didShowOnboarding = true
				appNavigation.showsOnboarding = false
			}
		}
	}
}

#Preview {
	ThirdPageView()
		.styledPreview()
}
