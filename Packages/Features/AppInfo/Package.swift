// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppInfo",
	platforms: [.iOS(.v26)],
	products: [
		.library(name: "AppInfo", targets: ["AppInfo"]),
	],
	dependencies: [
		.package(name: "Settings", path: "../../Library/Settings"),
		.package(name: "SharedComponents", path: "../../Library/SharedComponents"),
		.package(name: "Utils", path: "../../Library/Utils"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	],
	targets: [
		.target(name: "AppInfo", dependencies: [
			.product(name: "Settings", package: "Settings"),
			.product(name: "Utils", package: "Utils"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
		], resources: [
			.process("Resources"),
		]),
	]
)
