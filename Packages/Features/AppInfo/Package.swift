// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppInfo",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "AppInfoDomain", targets: ["AppInfoDomain"]),
		.library(name: "AppInfoUI", targets: ["AppInfoUI"]),
	],
	dependencies: [
		.package(name: "Settings", path: "../../Library/Settings"),
		.package(name: "SharedComponents", path: "../../Library/SharedComponents"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	],
	targets: [
		.target(name: "AppInfoDomain"),
		.target(name: "AppInfoUI", dependencies: [
			.product(name: "Settings", package: "Settings"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			"AppInfoDomain",
		], resources: [
			.process("Resources"),
		]),
	]
)
