//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public protocol TodoListProvider {
	var sections: [TodoSection] { get }
	
	var entries: [TodoListEntry] { get }
	
	func toggleDateExcluded(_ date: Date)
}

public extension TodoListProvider {
	func id(after id: UUID) -> UUID? {
		guard var index = entries.firstIndex(where: { entry in
			guard case let .item(entryID, _, _, _) = entry else {
				return false
			}

			return entryID == id
		}) else {
			return nil
		}
				
		index += 1
		
		while index < entries.count {
			if case let .item(id, _, _, _) = entries[index] {
				return id
			}
			
			index += 1
		}
		
		return nil
	}
	
	func id(before id: UUID) -> UUID? {
		guard var index = entries.firstIndex(where: { entry in
			guard case let .item(entryID, _, _, _) = entry else {
				return false
			}
			
			return entryID == id
		}) else {
			return nil
		}
		
		index -= 1
		
		while index > 0 {
			if case let .item(id, _, _, _) = entries[index] {
				return id
			}
			
			index -= 1
		}
		
		return nil
	}
}
