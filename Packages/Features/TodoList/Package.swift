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
	targets: [
		.target(name: "TodoListData", dependencies: [
			"TodoListDomain",
		]),
		.target(name: "TodoListDomain"),
		.target(name: "TodoListUI", dependencies: [
			"TodoListDomain",
		]),
		.testTarget(
			name: "TodoListDataTests",
			dependencies: ["TodoListData"]),
	]
)
