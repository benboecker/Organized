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
		.package(name: "Persistence", path: "../Library/Persistence"),
		.package(name: "Styleguide", path: "../Library/Styleguide"),
		.package(name: "SharedComponents", path: "../Library/SharedComponents"),
	],
	targets: [
		.target(name: "TodoListData", dependencies: [
			.product(name: "Persistence", package: "Persistence"),
			"TodoListDomain",
		]),
		.target(name: "TodoListDomain"),
		.target(name: "TodoListUI", dependencies: [
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			"TodoListDomain",
		], resources: [
			.process("weekdays.json"),
		]),
		.testTarget(
			name: "TodoListDataTests",
			dependencies: ["TodoListData"]),
	]
)
