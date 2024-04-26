// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppLaunch",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "AppLaunch", targets: ["AppLaunch"]),
	],
	dependencies: [
		.package(name: "Alerts", path: "Library/Alerts"),
		.package(name: "NewTodo", path: "Features/NewTodo"),
		.package(name: "SharedComponents", path: "Library/SharedComponents"),
		.package(name: "Styleguide", path: "Library/Styleguide"),
		.package(name: "TodoList", path: "Features/TodoList"),
	],
	targets: [
		.target(name: "AppLaunch", dependencies: [
			.product(name: "Alerts", package: "Alerts"),
			.product(name: "NewTodoData", package: "NewTodo"),
			.product(name: "NewTodoDomain", package: "NewTodo"),
			.product(name: "NewTodoUI", package: "NewTodo"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "TodoListData", package: "TodoList"),
			.product(name: "TodoListDomain", package: "TodoList"),
			.product(name: "TodoListUI", package: "TodoList"),
		]),
	]
)
