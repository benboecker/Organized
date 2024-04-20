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
	
	],
	targets: [
		.target(name: "AppLaunch", dependencies: [

		]),
	]
)
