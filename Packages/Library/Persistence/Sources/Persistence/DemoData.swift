//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.05.24.
//

import Foundation
import CoreData


struct DemoData {
	private init() { }
	
	private struct DemoTodo: Codable {
		init(
			title: String,
			isImportant: Bool,
			dueInDays: Int?,
			doneDaysAgo: Int?,
			createdDaysAgo: Int
		) {
			let cal = Calendar.current
			self.title = title
			self.isImportant = isImportant
			if let dueInDays {
				self.dueDate = cal.date(byAdding: .day, value: dueInDays, to: .now)
			} else {
				self.dueDate = nil
			}
			if let doneDaysAgo {
				self.doneDate = cal.date(byAdding: .day, value: -doneDaysAgo, to: .now)
			} else {
				self.doneDate = nil
			}


			self.createdDate = cal.date(byAdding: .day, value: -createdDaysAgo, to: .now)!
		}
		
		let title: String
		let isImportant: Bool
		let dueDate: Date?
		let doneDate: Date?
		let createdDate: Date
	}
	
	private static let todos: [DemoTodo] = [
		DemoTodo(title: "Einkäufe für das Wochenende erledigen",            isImportant: false,  dueInDays: 2,   doneDaysAgo: nil, createdDaysAgo: 1),
		DemoTodo(title: "Geburtstagsgeschenk für Anna besorgen",            isImportant: false,  dueInDays: 5,   doneDaysAgo: nil, createdDaysAgo: 2),
		DemoTodo(title: "Arzttermin für Impfung vereinbaren",               isImportant: true,   dueInDays: 7,   doneDaysAgo: nil, createdDaysAgo: 3),
		DemoTodo(title: "Fahrrad zur Reparatur bringen",                    isImportant: false,  dueInDays: nil, doneDaysAgo: 2,   createdDaysAgo: 4),
		DemoTodo(title: "Buch über Selbstverbesserung lesen",               isImportant: false,  dueInDays: 10,  doneDaysAgo: nil, createdDaysAgo: 5),
		DemoTodo(title: "Mit dem Laufen beginnen",                          isImportant: false,  dueInDays: nil, doneDaysAgo: 6,   createdDaysAgo: 6),
		DemoTodo(title: "Reise nach Paris planen",                          isImportant: true,   dueInDays: 30,  doneDaysAgo: nil, createdDaysAgo: 7),
		DemoTodo(title: "Wichtige Dokumente scannen und speichern",         isImportant: false,  dueInDays: nil, doneDaysAgo: 3,   createdDaysAgo: 8),
		DemoTodo(title: "Neue Sprache lernen - Spanisch",                   isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 9),
		DemoTodo(title: "Wochenmenü planen und einkaufen",                  isImportant: true,   dueInDays: 2,   doneDaysAgo: nil, createdDaysAgo: 10),
		DemoTodo(title: "Freunde zum Grillabend einladen",                  isImportant: false,  dueInDays: 7,   doneDaysAgo: 4,   createdDaysAgo: 11),
		DemoTodo(title: "Auto waschen und polieren",                        isImportant: false,  dueInDays: nil, doneDaysAgo: 1,   createdDaysAgo: 12),
		DemoTodo(title: "Keller entrümpeln und organisieren",               isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 13),
		DemoTodo(title: "Yogaübungen für Entspannung durchführen",          isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 14),
		DemoTodo(title: "Investitionsmöglichkeiten recherchieren",          isImportant: false,  dueInDays: 15,  doneDaysAgo: nil, createdDaysAgo: 15),
		DemoTodo(title: "Einen Tag nur für sich selbst planen",             isImportant: false,  dueInDays: nil, doneDaysAgo: 7,   createdDaysAgo: 16),
		DemoTodo(title: "Gartenarbeit - Pflanzen gießen und Unkraut jäten", isImportant: true,   dueInDays: 3,   doneDaysAgo: nil, createdDaysAgo: 17),
		DemoTodo(title: "Einen neuen Podcast entdecken und anhören",        isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 18),
		DemoTodo(title: "Wochenendtrip in die Berge buchen",                isImportant: false,  dueInDays: 20,  doneDaysAgo: nil, createdDaysAgo: 19),
		DemoTodo(title: "Frühjahrsputz in der Wohnung durchführen",         isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 20)
	]
	
	static func create(in context: NSManagedObjectContext) {
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
