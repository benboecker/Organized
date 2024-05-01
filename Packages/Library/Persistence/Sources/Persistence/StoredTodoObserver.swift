//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.05.24.
//

import Foundation
import CoreData
import OSLog



public class StoredTodoObserver: NSObject, NSFetchedResultsControllerDelegate {
	
	private var didChangeObjects: ([StoredTodo]) -> Void = { _ in }
	private let fetchedResultsController: NSFetchedResultsController<StoredTodo>
	private let logger = Logger(subsystem: "Persistence", category: "ManagedObjectContextObserver")
	
	public init(context: NSManagedObjectContext) {
		let fetchRequest = NSFetchRequest<StoredTodo>(entityName: StoredTodo.entity().name!)
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(keyPath: \StoredTodo.isImportant, ascending: false),
			NSSortDescriptor(keyPath: \StoredTodo.createdDate, ascending: true),
		]
		let startOfToday = Calendar.current.startOfDay(for: .now)
//		fetchRequest.predicate = NSPredicate(format: "doneDate == NULL")
		fetchRequest.predicate = NSPredicate(format: "doneDate == NULL || doneDate > %@", startOfToday as CVarArg)
		
		self.fetchedResultsController = NSFetchedResultsController<StoredTodo>(
			fetchRequest: fetchRequest,
			managedObjectContext: context,
			sectionNameKeyPath: nil,
			cacheName: nil
		)
		
		super.init()
		
		fetchedResultsController.delegate = self
		try! fetchedResultsController.performFetch()
		
		logger.notice("Initialized ManagedObjectContextObserver for entity \(StoredTodo.entity().name!)")
	}
	
	public func didChangeObjects(_ handler: @escaping ([StoredTodo]) -> Void) {
		self.didChangeObjects = handler
		didChangeObjects(fetchedResultsController.fetchedObjects ?? [])
	}
	
	public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let fetchedObjects = controller.fetchedObjects as? [StoredTodo] else {
			logger.notice("controllerDidChangeContent could not get any fetched objects of type \(StoredTodo.entity().name!)")
			return
		}
		
		logger.notice("controllerDidChangeContent with \(fetchedObjects.count) \(StoredTodo.entity().name!) objects")
		
		didChangeObjects(fetchedObjects)
	}
}
