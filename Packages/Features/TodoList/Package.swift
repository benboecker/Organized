// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "TodoList",
	platforms: [.iOS(.v26)],
	products: [
		.library(name: "TodoList", targets: ["TodoList"]),
	],
	dependencies: [
		.package(name: "DemoData", path: "../../Library/DemoData"),
		.package(name: "Persistence", path: "../../Library/Persistence"),
		.package(name: "Settings", path: "../../Library/Settings"),
		.package(name: "SharedComponents", path: "../../Library/SharedComponents"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
		.package(name: "Utils", path: "../../Library/Utils"),
	],
	targets: [
		.target(name: "TodoList", dependencies: [
			.product(name: "DemoData", package: "DemoData"),
			.product(name: "Persistence", package: "Persistence"),
			.product(name: "Settings", package: "Settings"),
			.product(name: "Utils", package: "Utils"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
		]),
		.testTarget(
			name: "TodoListDataTests",
			dependencies: [
				.product(name: "Settings", package: "Settings"),
				"TodoList",
			]
		),
	]
)
