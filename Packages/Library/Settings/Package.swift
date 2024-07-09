// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Settings",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "Settings", targets: ["Settings"]),
	],
	dependencies: [
		
	],
	targets: [
		.target(name: "Settings"),
		.testTarget(name: "SettingsTests", dependencies: ["Settings"])
	]
)

