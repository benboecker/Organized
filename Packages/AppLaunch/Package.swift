// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppLaunch",
	platforms: [.iOS(.v26)],
	products: [
		.library(name: "AppLaunch", targets: ["AppLaunch"]),
	],
	dependencies: [
		.package(name: "AppInfo", path: "../Features/AppInfo"),
		.package(name: "NewTodo", path: "../Features/NewTodo"),
		.package(name: "Onboarding", path: "../Features/Onboarding"),
		.package(name: "Persistence", path: "../Library/Persistence"),
		.package(name: "Settings", path: "../Library/Settings"),
		.package(name: "SharedComponents", path: "../Library/SharedComponents"),
		.package(name: "Styleguide", path: "../../../../Packages/Styleguide"),
		.package(name: "SwiftUITools", path: "../../../../Packages/SwiftUITools"),
		.package(name: "TodoList", path: "../Features/TodoList"),
	],
	targets: [
		.target(name: "AppLaunch", dependencies: [
			.product(name: "AppInfo", package: "AppInfo"),
			.product(name: "NewTodo", package: "NewTodo"),
			.product(name: "Onboarding", package: "Onboarding"),
			.product(name: "Persistence", package: "Persistence"),
			.product(name: "Settings", package: "Settings"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "TodoList", package: "TodoList"),
		]),
	]
)
