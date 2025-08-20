// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "NewTodo",
	platforms: [.iOS(.v26)],
	products: [
		.library(name: "NewTodo", targets: ["NewTodo"]),
	],
	dependencies: [
		.package(name: "Persistence", path: "../../Library/Persistence"),
		.package(name: "SharedComponents", path: "../../Library/SharedComponents"),
		.package(name: "Settings", path: "../../Library/Settings"),
		.package(name: "Utils", path: "../../Library/Utils"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	],
	targets: [
		.target(name: "NewTodo", dependencies: [
			.product(name: "Persistence", package: "Persistence"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "Settings", package: "Settings"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Utils", package: "Utils"),
		]),
		.testTarget(
			name: "NewTodoTests",
			dependencies: [
				"NewTodo"
			]),
	]
)
