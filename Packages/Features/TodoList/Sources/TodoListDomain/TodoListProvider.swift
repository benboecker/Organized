//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol TodoListProvider {
	var entries: [TodoListEntry] { get }
	
	func toggleDateExcluded(_ date: Date)
}
