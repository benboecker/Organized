//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 08.10.23.
//

import Foundation
import CoreData
import Combine
import UIKit
import OSLog
import DemoData



public class PersistentContainer {
	public let storageConfig: StorageConfig
	private let observer: PersistentHistoryObserver
	private let container: NSPersistentContainer
	private var cancellables: Set<AnyCancellable> = []
	private let logger = Logger(subsystem: "Persistence", category: "PersistentContainer")
	
	required public init(with storageConfig: StorageConfig) {
		self.storageConfig = storageConfig

		guard let modelURL = Bundle.module.url(forResource: "DataModel", withExtension: "momd") else {
			fatalError()
		}
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError()
		}
		
//		container = NSPersistentCloudKitContainer(name: .appName, managedObjectModel: model)
		container = NSPersistentContainer(name: .appName, managedObjectModel: model)
		container.viewContext.automaticallyMergesChangesFromParent = true
		container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		container.viewContext.transactionAuthor = storageConfig.isExtension ? .extensionTransactionAuthorName : .appTransactionAuthorName
		container.viewContext.name = storageConfig.isExtension ? .extensionViewContextName : .viewContextName

		if storageConfig.inMemory {
			let storeDescription = NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null/organized.sqlite"))
			storeDescription.type = NSSQLiteStoreType
			storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
			storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
			
			container.persistentStoreDescriptions = [storeDescription]
		} else {
			// Create a store description for a CloudKit-backed local store
			let cloudStoreDescription = NSPersistentStoreDescription(url: PersistentContainer.fileURL())
			cloudStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
			cloudStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
			cloudStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: .iCloudContainer)
			container.persistentStoreDescriptions = [cloudStoreDescription]
		}
		
		observer = PersistentHistoryObserver(
			target: storageConfig.isExtension ? .shareExtension : .app,
			persistentContainer: container,
			userDefaults: .standard
		)
		
		container.loadPersistentStores { [weak self] (description, error) in
			guard let self else { return }

			if let error = error as NSError? {
				self.logger.error("\(error)")
			} else {
				self.logger.error("Loaded store: \(description.configuration ?? "-")")
			}
		}
		
//		do {
//			try container.initializeCloudKitSchema()
//		} catch {
//			fatalError("\(error)")
//		}
		
		NotificationCenter.default
			.publisher(for: UIApplication.didEnterBackgroundNotification)
			.sink { [weak self] _ in
				try? self?.mainContext.save()
			}
			.store(in: &cancellables)
	}
	
	deinit {
		cancellables.forEach { cancellable in
			cancellable.cancel()
		}
	}
}


public extension PersistentContainer {
	var mainContext: NSManagedObjectContext {
		container.viewContext
	}
	
	func createBackgroundContext() -> NSManagedObjectContext {
		let context = container.newBackgroundContext()
		context.transactionAuthor = .appTransactionAuthorName
		context.name = "background_context"
		context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

		return context
	}
	
	func createDemoData() {
		let context = createBackgroundContext()
		context.performAndWait {
			let count = countObjects(ofType: StoredTodo.self, in: context)
			
			guard count == 0 else { return }
			
				let demoTodos = DemoData.todos
				
				for todo in demoTodos {
					let newTodo = StoredTodo(context: context)
					newTodo.id = UUID()
					newTodo.createdDate = todo.createdDate
					newTodo.doneDate = todo.doneDate
					newTodo.dueDate = todo.dueDate
					newTodo.isImportant = todo.isImportant
					newTodo.title = todo.title
				}
				
				try! context.save()

		}
	}
	
	func createObject<Object: NSManagedObject & Identifiable>(in context: NSManagedObjectContext? = nil, configuration: (Object) -> Void) where Object.ID == UUID {
		let context = context ?? createBackgroundContext()
		context.performAndWait { [weak self] in
			let newObject = Object(context: context)
			configuration(newObject)
			
			try! context.save()
			self?.logger.notice("Created new \(Object.entity().name!) object with id \(newObject.id) (\(newObject.objectID.uriRepresentation().absoluteString)")
		}
	}
	
	func countObjects<Object: NSManagedObject>(ofType t: Object.Type,  predicate: NSPredicate? = nil, in context: NSManagedObjectContext? = nil) -> Int {
		let context = context ?? mainContext
		
		let fetchRequest = NSFetchRequest<Object>(entityName: Object.entity().name!)
		fetchRequest.predicate = predicate
		
		do {
			let fetched = try context.count(for: fetchRequest)
			return fetched
		} catch {
			logger.error("\(error)")
			return 0
		}
	}
	
	func getObjects<Object: NSManagedObject>(sortedBy sortDescriptors: [NSSortDescriptor], predicate: NSPredicate? = nil, in context: NSManagedObjectContext? = nil) -> [Object] {
		let context = context ?? mainContext
		
		let fetchRequest = NSFetchRequest<Object>(entityName: Object.entity().name!)
		fetchRequest.sortDescriptors = sortDescriptors
		fetchRequest.predicate = predicate
		
		do {
			let fetched = try context.fetch(fetchRequest)
			return fetched
		} catch {
			logger.error("\(error)")
			return []
		}
	}
	
	func getObject<Object: NSManagedObject & Identifiable>(with id: Object.ID, in context: NSManagedObjectContext? = nil) -> Object? where Object.ID == UUID {
		let context = context ?? mainContext
		
		let fetchRequest = NSFetchRequest<Object>(entityName: Object.entity().name!)
		fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
		fetchRequest.fetchLimit = 1
		do {
			let fetched = try context.fetch(fetchRequest)
			return fetched.first
		} catch {
			print("\(error)")
			return nil
		}
		
	}

	func updateObject<Object: NSManagedObject & Identifiable>(with id: Object.ID, in context: NSManagedObjectContext? = nil, configuration: (Object) -> Void) where Object.ID == UUID {
		let context = context ?? createBackgroundContext()
		context.performAndWait { [weak self] in
			guard let fetchedObject: Object = self?.getObject(with: id, in: context) else {
				return
			}
			
			configuration(fetchedObject)
			
			try! context.save()

			self?.logger.notice("Updated \(Object.entity().name!) object with id \(id)")
		}
	}
	
	func deleteObject<Object: NSManagedObject & Identifiable>(objectType: Object.Type, with id: Object.ID, in context: NSManagedObjectContext? = nil) where Object.ID == UUID {
		let context = context ?? mainContext
		context.performAndWait { [weak self] in
			guard let fetchedObject: Object = self?.getObject(with: id, in: context) else {
				return
			}
			
			context.delete(fetchedObject)
			try! context.save()
			
			self?.logger.notice("Deleted \(Object.entity().name!) object with id \(id)")
		}
	}
}


private extension PersistentContainer {
	static func fileURL() -> URL {
		guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: .appGroup) else {
			fatalError("Shared file container could not be created.")
		}
		
		return fileContainer.appendingPathComponent("organized.sqlite")
	}
}
