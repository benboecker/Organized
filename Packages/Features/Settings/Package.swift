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
	targets: [
		.target(name: "SettingsData", dependencies: [
			"SettingsDomain",
		]),
		.target(name: "SettingsDomain"),
		.target(name: "SettingsUI", dependencies: [
			"SettingsDomain",
		]),
		.testTarget(
			name: "SettingsDataTests",
			dependencies: ["SettingsData"]),
	]
)
