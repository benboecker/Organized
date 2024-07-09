// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "TodoList",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "TodoListData", targets: ["TodoListData"]),
		.library(name: "TodoListDomain", targets: ["TodoListDomain"]),
		.library(name: "TodoListUI", targets: ["TodoListUI"]),
	],
	dependencies: [
		.package(name: "DemoData", path: "../Library/DemoData"),
		.package(name: "Persistence", path: "../Library/Persistence"),
		.package(name: "Settings", path: "../Library/Settings"),
		.package(name: "SharedComponents", path: "../Library/SharedComponents"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
		.package(name: "Utils", path: "../Library/Utils"),
	],
	targets: [
		.target(name: "TodoListData", dependencies: [
			.product(name: "Persistence", package: "Persistence"),
			.product(name: "Settings", package: "Settings"),
			.product(name: "Utils", package: "Utils"),
			"TodoListDomain",
		]),
		.target(name: "TodoListDomain"),
		.target(name: "TodoListUI", dependencies: [
			.product(name: "DemoData", package: "DemoData"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Utils", package: "Utils"),
			"TodoListDomain",
		]),
		.testTarget(
			name: "TodoListDataTests",
			dependencies: ["TodoListData"]
		),
	]
)
