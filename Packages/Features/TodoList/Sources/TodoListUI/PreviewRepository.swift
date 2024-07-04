//
//  File.swift
//
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation
import TodoListDomain


class PreviewRepository: TodoListProvider, TodoRepository {
	
	
	init() {
		self.entries = .preview
	}
	
	var entries: [TodoListEntry] = []
	
	func toggleDateExcluded(_ date: Date) {
		
	}
	
	func update(isImportant: Bool, of todoID: UUID) {
		
	}
	
	func update(isDone: Bool, of todoID: UUID) {
		
	}
	
	func update(title: String, of todoID: UUID) {
		
	}
	
	func update(dueDate: Date?, of todoID: UUID) {
		
	}
	
	func delete(todoID: UUID) {
		
	}
}

extension [TodoListEntry] {
	static var preview: [TodoListEntry] { [
		.headline(date: .now, isExcluded: false),
		.item(id: UUID(), title: "Geburtstagsgeschenk für Mama besorgen", isDone: false, priority: .overdue),
		.item(id: UUID(), title: "Gartenarbeit - Pflanzen gießen und Unkraut jäten", isDone: false, priority: .important),
		.item(id: UUID(), title: "Neue Sprache lernen - Spanisch", isDone: false, priority: .important),
		.headline(date: .now.addingTimeInterval(86400 * 1), isExcluded: false),
		.item(id: UUID(), title: "Reise nach Paris planen", isDone: false, priority: .important),
		.item(id: UUID(), title: "Buch über Selbstverbesserung lesen", isDone: false, priority: .important),
		.item(id: UUID(), title: "Investitionsmöglichkeiten recherchieren", isDone: false, priority: .important),
		.item(id: UUID(), title: "Wochenendtrip in die Berge buchen", isDone: false, priority: .important),
		.headline(date: .now.addingTimeInterval(86400 * 2), isExcluded: false),
		.item(id: UUID(), title: "Wochenmenü planen und einkaufen", isDone: false, priority: .important),
		.item(id: UUID(), title: "Einkäufe für das Wochenende erledigen", isDone: false, priority: .important),
		.item(id: UUID(), title: "Arzttermin für Impfung vereinbaren", isDone: false, priority: .important),
		.headline(date: .now.addingTimeInterval(86400 * 3), isExcluded: false),
		.item(id: UUID(), title: "Keller entrümpeln und organisieren", isDone: false, priority: .important),
		.item(id: UUID(), title: "Fahrrad zur Reparatur bringen", isDone: true, priority: .normal),
		.item(id: UUID(), title: "Mit dem Laufen beginnen", isDone: false, priority: .normal),
		.headline(date: .now.addingTimeInterval(86400 * 4), isExcluded: false),
		.item(id: UUID(), title: "Wichtige Dokumente scannen und speichern", isDone: false, priority: .normal),
		.item(id: UUID(), title: "Freunde zum Grillabend einladen", isDone: false, priority: .normal),
		.item(id: UUID(), title: "Auto waschen und polieren", isDone: true, priority: .normal),
		.headline(date: .now.addingTimeInterval(86400 * 5), isExcluded: false),
		.item(id: UUID(), title: "Yogaübungen für Entspannung durchführen", isDone: false, priority: .normal),
		.item(id: UUID(), title: "Einen Tag nur für sich selbst planen", isDone: true, priority: .normal),
		.item(id: UUID(), title: "Einen neuen Podcast entdecken und anhören", isDone: false, priority: .normal),
		.headline(date: .now.addingTimeInterval(86400 * 6), isExcluded: false),
		.item(id: UUID(), title: "Frühjahrsputz in der Wohnung durchführen", isDone: false, priority: .normal),
		
	] }
}
