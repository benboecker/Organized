//
//  File.swift
//  Onboarding
//
//  Created by Benjamin Böcker on 14.07.24.
//

import Foundation


protocol OnboardingDataProvider {
	var pages: [OnboardingPage] { get }
}
