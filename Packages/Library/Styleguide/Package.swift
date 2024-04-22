// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Styleguide",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "Styleguide", targets: ["Styleguide"]),
	],
	targets: [
		.target(name: "Styleguide"),
	]
)
