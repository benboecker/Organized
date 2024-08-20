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



//public extension View {
//	func appInformationSheet() -> some View {
//		modifier(AppInformationSheet())
//	}	
//}
//
//
//
//struct AppInformationSheet: ViewModifier {
//	
//	@Environment(\.appNavigation) private var appNavigation
//	
//	func body(content: Content) -> some View {
//		content
//			.sheet(isPresented: appNavigation.showsAppInfo) {
//				AppInfoView()
//					.sheet(isPresented: appNavigation.showsAppInfoOnboarding) {
//						OnboardingView()
//					}
//			}
//	}
//	
//	
//}
