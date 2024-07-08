//
//  StoredTodo+CoreDataClass.swift
//  Organized App
//
//  Created by Benjamin Böcker on 30.04.24.
//
//

import Foundation
import CoreData

@objc(StoredTodo)
public class StoredTodo: NSManagedObject {
	public var isOverdue: Bool {
		if let dueDate, dueDate < Calendar.current.startOfDay(for: .now) {
			return true
		} else {
			return false
		}
	}
	
	public var notOverdue: Bool {
		!isOverdue
	}
}
