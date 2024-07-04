// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Settings",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "SettingsData", targets: ["SettingsData"]),
		.library(name: "SettingsDomain", targets: ["SettingsDomain"]),
		.library(name: "SettingsUI", targets: ["SettingsUI"]),
	],
	dependencies: [
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	],
	targets: [
		.target(name: "SettingsData", dependencies: [
			"SettingsDomain",
		]),
		.target(name: "SettingsDomain"),
		.target(name: "SettingsUI", dependencies: [
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			"SettingsDomain",
		]),
		.testTarget(
			name: "SettingsDataTests",
			dependencies: ["SettingsData"]),
	]
)
