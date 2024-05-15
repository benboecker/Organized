// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Persistence",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "Persistence", targets: ["Persistence"]),
	],
	dependencies: [
		.package(name: "DemoData", path: "../DemoData"),
	],
	targets: [
		.target(name: "Persistence", dependencies: [
			.product(name: "DemoData", package: "DemoData"),
		], resources: [
			.process("Resources"),
		]),
		.testTarget(name: "PersistenceTests", dependencies: [
			"Persistence",
		])
	]
)
