// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Onboarding",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "OnboardingDomain", targets: ["OnboardingDomain"]),
		.library(name: "OnboardingUI", targets: ["OnboardingUI"]),
	],
	dependencies: [
		.package(name: "Settings", path: "../../Library/Settings"),
		.package(name: "SharedComponents", path: "../../Library/SharedComponents"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
		.package(name: "Utils", path: "../../Library/Utils"),
	],
	targets: [
		.target(name: "OnboardingDomain"),
		.target(name: "OnboardingUI", dependencies: [
			"OnboardingDomain",
			.product(name: "Settings", package: "Settings"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "Utils", package: "Utils"),

		]),
	]
)

