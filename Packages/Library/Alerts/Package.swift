// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Alerts",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "Alerts", targets: ["Alerts"]),
	],
	targets: [
		.target(name: "Alerts"),
	]
)
