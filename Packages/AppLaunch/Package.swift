// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppLaunch",
	platforms: [.iOS("18.0.0")],
	products: [
		.library(name: "AppLaunch", targets: ["AppLaunch"]),
	],
	dependencies: [
		.package(name: "Alerts", path: "../../../../Packages/Alerts"),
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
			.product(name: "Alerts", package: "Alerts"),
			.product(name: "AppInfoUI", package: "AppInfo"),
			.product(name: "NewTodoData", package: "NewTodo"),
			.product(name: "NewTodoDomain", package: "NewTodo"),
			.product(name: "NewTodoUI", package: "NewTodo"),
//			.product(name: "OnboardingData", package: "Onboarding"),
			.product(name: "OnboardingDomain", package: "Onboarding"),
			.product(name: "OnboardingUI", package: "Onboarding"),
			.product(name: "Persistence", package: "Persistence"),
			.product(name: "Settings", package: "Settings"),
			.product(name: "SharedComponents", package: "SharedComponents"),
			.product(name: "Styleguide", package: "Styleguide"),
			.product(name: "SwiftUITools", package: "SwiftUITools"),
			.product(name: "TodoListData", package: "TodoList"),
			.product(name: "TodoListDomain", package: "TodoList"),
			.product(name: "TodoListUI", package: "TodoList"),
		]),
	]
)
