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
	
}

public extension Array {
	mutating func extract(_ isIncluded: (Element) -> Bool) -> [Element] {
		let extracted = filter(isIncluded)
		removeAll(where: isIncluded)
		
		return extracted
	}

}
