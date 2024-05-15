// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "DemoData",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "DemoData", targets: ["DemoData"]),
	],
	targets: [
		.target(name: "DemoData"),
	]
)
