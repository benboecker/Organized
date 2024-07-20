//
//  SwiftUIView.swift
//  Onboarding
//
//  Created by Benjamin Böcker on 14.07.24.
//

import SwiftUI
import OnboardingDomain
import Styleguide
import Settings
import SwiftUITools
import SharedComponents


public struct OnboardingView: View {
	public init() { }
	
	@State private var selectedPage: Int? = 0
	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings

	public var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				ScrollView(.horizontal) {
					LazyHStack(spacing: 0) {
						ForEach(OnboardingPage.allCases, id: \.self) { page in
							OnboardingPageView(for: page)
								.padding(.horizontal, styleguide.extraLarge)
								.containerRelativeFrame(.horizontal)
								.id(OnboardingPage.allCases.firstIndex(of: page) ?? 0)
						}
					}
					.scrollTargetLayout()
				}
				.scrollTargetBehavior(.paging)
				.scrollIndicators(.hidden)
				.scrollPosition(id: $selectedPage)
				
				VStack(spacing: styleguide.large) {
					PageIndicatorView(
						numberOfPages: OnboardingPage.allCases.count,
						currentPage: $selectedPage
					)
					.pageIndicatorTintColor(styleguide.secondaryText)
					.currentPageIndicatorTintColor(styleguide.primaryText)
		
				}
				.padding(.horizontal, styleguide.large)
			}
		}
	}
	
	@ViewBuilder
	func OnboardingPageView(for page: OnboardingPage) -> some View {
		switch page {
		case .first: FirstPageView()
		case .second: SecondPageView()
		case .third: ThirdPageView()
		}
	}
}




#Preview {
	OnboardingView()
		.styledPreview()
}
