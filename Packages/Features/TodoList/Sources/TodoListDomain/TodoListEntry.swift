//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 14.05.24.
//

import Foundation


public enum TodoListEntry: Hashable {
	case headline(date: Date, isExcluded: Bool)
	case item(id: UUID, title: String, isDone: Bool, priority: Priority)
}

public extension TodoListEntry {
	var isHeadline: Bool {
		switch self {
		case .headline: true
		case .item: false
		}
	}
	
	var title: String {
		switch self {
		case .headline(let date, _): date.formatted(.dateTime.weekday(.wide).day().month())
		case .item(_, let title, _, _): title			
		}
	}
	
	enum Priority: Comparable {
		case overdue
//		case due
		case important
		case normal
	}
}
