// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedComponents",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "SharedComponents", targets: ["SharedComponents"]),
	],
	dependencies: [
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	]
	,targets: [
		.target(name: "SharedComponents", dependencies: [
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
		]),
	]
)
