// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "NewTodo",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "NewTodoData", targets: ["NewTodoData"]),
		.library(name: "NewTodoDomain", targets: ["NewTodoDomain"]),
		.library(name: "NewTodoUI", targets: ["NewTodoUI"]),
	],
	dependencies: [
		.package(name: "Persistence", path: "../Library/Persistence"),
		.package(name: "Styleguide", path: "../../../../../Packages/Styleguide"),
		.package(name: "SharedComponents", path: "../Library/SharedComponents"),
		.package(name: "SwiftUITools", path: "../../../../../Packages/SwiftUITools"),
	],
	targets: [
		.target(name: "NewTodoData", dependencies: [
			.product(name: "Persistence", package: "Persistence"),
			"NewTodoDomain",
		]),
		.target(name: "NewTodoDomain"),
		.target(name: "NewTodoUI", dependencies: [
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			"NewTodoDomain",
		]),
		.testTarget(
			name: "NewTodoDataTests",
			dependencies: ["NewTodoData"]),
	]
)
