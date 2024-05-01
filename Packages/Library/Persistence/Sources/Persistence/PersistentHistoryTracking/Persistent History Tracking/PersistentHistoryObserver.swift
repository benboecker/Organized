//
//  File.swift
//  
//
//  Created by Benni on 12.09.20.
//

import Foundation
import CoreData


public final class PersistentHistoryObserver {

	private let target: AppTarget
	private let userDefaults: UserDefaults
	private let persistentContainer: NSPersistentContainer

	/// An operation queue for processing history transactions.
	private lazy var historyQueue: OperationQueue = {
		let queue = OperationQueue()
		queue.maxConcurrentOperationCount = 1
		return queue
	}()

	public init(target: AppTarget, persistentContainer: NSPersistentContainer, userDefaults: UserDefaults = .standard) {
		self.target = target
		self.userDefaults = userDefaults
		self.persistentContainer = persistentContainer

		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleNotification),
			name: .NSPersistentStoreRemoteChange, 
			object: persistentContainer.persistentStoreCoordinator
		)

	}

	@objc func handleNotification(_ notification: Notification) {
		historyQueue.addOperation { [weak self] in
			self?.processPersistentHistory()
		}
	}
	
	@objc private func processPersistentHistory() {
		let context = persistentContainer.newBackgroundContext()
		context.performAndWait {
			do {
				let merger = PersistentHistoryMerger(backgroundContext: context, viewContext: persistentContainer.viewContext, currentTarget: target, userDefaults: userDefaults)
				try merger.merge()

				let cleaner = PersistentHistoryCleaner(context: context, targets: AppTarget.allCases, userDefaults: userDefaults)
				try cleaner.clean()
			} catch {
				print("Persistent History Tracking failed with error \(error)")
			}
		}
	}
}
