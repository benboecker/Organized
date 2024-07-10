//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 28.02.24.
//

import Foundation


public extension Collection {
	var hasContent: Bool { !isEmpty }
	
	func count(where predicate: (Element) -> Bool) -> Int {
		filter(predicate).count
	}
	
	func count(_ keypath: KeyPath<Element, Bool>) -> Int {
		filter { $0[keyPath: keypath] }.count		
	}
	
}

public extension Array {
	/// Removes and returns all elements that return `true` for the given function
	mutating func extract(_ isIncluded: (Element) -> Bool) -> [Element] {
		let extracted = filter(isIncluded)
		removeAll(where: isIncluded)
		
		return extracted
	}
	
	/// Removes and returns the first given number of elements
	mutating func extract(first numberOfElements: Int) -> [Element] {
		guard numberOfElements >= 0 else {
			return []
		}
		
		let firstElements = prefix(numberOfElements)
		
		if numberOfElements <= count {
			removeFirst(numberOfElements)
		} else {
			removeAll()
		}
		
		return Array(firstElements)
	}
	
	
}
