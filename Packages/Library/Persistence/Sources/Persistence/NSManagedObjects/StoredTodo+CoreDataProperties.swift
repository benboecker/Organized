//
//  StoredTodo+CoreDataProperties.swift
//  Organized App
//
//  Created by Benjamin Böcker on 30.04.24.
//
//

import Foundation
import CoreData


extension StoredTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredTodo> {
        return NSFetchRequest<StoredTodo>(entityName: "StoredTodo")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var isImportant: Bool
    @NSManaged public var doneDate: Date?
    @NSManaged public var createdDate: Date
    @NSManaged public var dueDate: Date?

}

extension StoredTodo : Identifiable {
	
}
