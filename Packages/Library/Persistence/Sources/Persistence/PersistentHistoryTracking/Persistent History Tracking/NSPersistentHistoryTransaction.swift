//
//  File.swift
//  
//
//  Created by Benni on 12.03.20.
//

import Foundation
import CoreData

extension NSPersistentHistoryTransaction {
	open override var description: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		var description = "\n\(dateFormatter.string(from: timestamp))"
		description += " (\(self.transactionNumber))"
		if let author = author {
			description += " '\(author)' "
		}
		if let context = contextName {
			description += ", >\(context)< "
		}
		
		if let changes = self.changes {
			let dict: [NSPersistentHistoryChangeType: [NSPersistentHistoryChange]] = Dictionary(grouping: changes) { el in
				el.changeType
			}
			
			for (change, values) in dict {
				let ch: String
				switch change {
				case .insert: ch = "+ Inserted"
				case .update: ch = "= Updated"
				case .delete: ch = "- Deleted"
				@unknown default: ch = ""
				}
				description += "\n\t\(ch) - \(values.count) Objects"
			}
		}
		
		
		return description
	}
}
