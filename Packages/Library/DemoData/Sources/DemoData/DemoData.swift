//
//  File.swift
//
//
//  Created by Benjamin Böcker on 01.05.24.
//

import Foundation

public enum DemoData { }

public extension DemoData {
	struct Todo: Codable {
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
		
		public let title: String
		public let isImportant: Bool
		public let dueDate: Date?
		public let doneDate: Date?
		public let createdDate: Date
	}
	
	static let todos: [Todo] = [
		Todo(title: "Einkäufe für das Wochenende erledigen",            isImportant: false,  dueInDays: 2,   doneDaysAgo: nil, createdDaysAgo: 20),
		Todo(title: "Geburtstagsgeschenk für Mama besorgen",            isImportant: false,  dueInDays: -5,  doneDaysAgo: nil, createdDaysAgo: 19),
		Todo(title: "Arzttermin für Impfung vereinbaren",               isImportant: true,   dueInDays: 7,   doneDaysAgo: nil, createdDaysAgo: 18),
		Todo(title: "Fahrrad zur Reparatur bringen",                    isImportant: false,  dueInDays: nil, doneDaysAgo: 0,   createdDaysAgo: 17),
		Todo(title: "Buch über Selbstverbesserung lesen",               isImportant: false,  dueInDays: 1,   doneDaysAgo: nil, createdDaysAgo: 16),
		Todo(title: "Mit dem Laufen beginnen",                          isImportant: false,   dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 15),
		Todo(title: "Reise nach Paris planen",                          isImportant: true,   dueInDays: 1,   doneDaysAgo: nil, createdDaysAgo: 14),
		Todo(title: "Wichtige Dokumente scannen und speichern",         isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 13),
		Todo(title: "Neue Sprache lernen - Spanisch",                   isImportant: false,  dueInDays: 0,   doneDaysAgo: nil, createdDaysAgo: 12),
		Todo(title: "Wochenmenü planen und einkaufen",                  isImportant: true,   dueInDays: 2,   doneDaysAgo: nil, createdDaysAgo: 11),
		Todo(title: "Freunde zum Grillabend einladen",                  isImportant: false,  dueInDays: 7,   doneDaysAgo: nil, createdDaysAgo: 10),
		Todo(title: "Auto waschen und polieren",                        isImportant: false,  dueInDays: nil, doneDaysAgo: 0,   createdDaysAgo: 9),
		Todo(title: "Keller entrümpeln und organisieren",               isImportant: true,   dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 8),
		Todo(title: "Yogaübungen für Entspannung durchführen",          isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 7),
		Todo(title: "Investitionsmöglichkeiten recherchieren",          isImportant: false,  dueInDays: 1,   doneDaysAgo: nil, createdDaysAgo: 6),
		Todo(title: "Einen Tag nur für sich selbst planen",             isImportant: false,  dueInDays: nil, doneDaysAgo: 0,   createdDaysAgo: 5),
		Todo(title: "Gartenarbeit - Pflanzen gießen und Unkraut jäten", isImportant: true,   dueInDays: 0,   doneDaysAgo: nil, createdDaysAgo: 4),
		Todo(title: "Einen neuen Podcast entdecken und anhören",        isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 3),
		Todo(title: "Wochenendtrip in die Berge buchen",                isImportant: false,  dueInDays: 1,   doneDaysAgo: nil, createdDaysAgo: 2),
		Todo(title: "Frühjahrsputz in der Wohnung durchführen",         isImportant: false,  dueInDays: nil, doneDaysAgo: nil, createdDaysAgo: 1),
	]
}
