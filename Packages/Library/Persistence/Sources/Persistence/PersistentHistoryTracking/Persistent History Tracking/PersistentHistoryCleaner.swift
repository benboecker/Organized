//
//  File.swift
//  
//
//  Created by Benni on 12.09.20.
//

import Foundation
import CoreData



struct PersistentHistoryCleaner {

	let context: NSManagedObjectContext
	let targets: [AppTarget]
	let userDefaults: UserDefaults

	/// Cleans up the persistent history by deleting the transactions that have been merged into each target.
	func clean() throws {
		guard let timestamp = userDefaults.lastCommonTransactionTimestamp(in: targets) else {
			return
		}

		let deleteHistoryRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: timestamp)
		print("Deleting persistent history using common timestamp \(timestamp)")
		try context.execute(deleteHistoryRequest)

		targets.forEach { target in
			/// Reset the dates as we would otherwise end up in an infinite loop.
			userDefaults.updateLastHistoryTransactionTimestamp(for: target, to: nil)
		}
	}
}
