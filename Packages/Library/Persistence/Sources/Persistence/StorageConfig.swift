//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 08.10.23.
//

import Foundation


public struct StorageConfig {
	public let inMemory: Bool
	public let createDemoData: Bool
	public let isExtension: Bool
}

public extension StorageConfig {	
	static let `extension` = StorageConfig(
		inMemory: false,
		createDemoData: false,
		isExtension: true
	)
	
	static let live = StorageConfig(
		inMemory: false,
		createDemoData: true,
		isExtension: false
	)

	static let testing = StorageConfig(
		inMemory: true,
		createDemoData: true,
		isExtension: false
	)
}
