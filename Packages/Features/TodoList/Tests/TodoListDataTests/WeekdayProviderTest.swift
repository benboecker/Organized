import XCTest
@testable import TodoListData
import Persistence


final class WeekdayProviderTest: XCTestCase {
	
	func test_CreateWeekdaysInitially() throws {
		ExcludedDates.removeAll()
		
		let container = PersistentContainer(with: .testing)
		container.createDemoData()
		
		let weekdayProvider = PersistentTodoListProvider(persistentContainer: container)
		
		XCTAssertEqual(weekdayProvider.sections.count, 7)
		
		XCTAssertEqual(weekdayProvider.sections[0].date.testFormat, dayTitle(in: 0))
		XCTAssertEqual(weekdayProvider.sections[0].todos[0].title, "Geburtstagsgeschenk für Mama besorgen")
		XCTAssertEqual(weekdayProvider.sections[0].todos[1].title, "Gartenarbeit - Pflanzen gießen und Unkraut jäten")
		XCTAssertEqual(weekdayProvider.sections[0].todos[2].title, "Neue Sprache lernen - Spanisch")
		XCTAssertEqual(weekdayProvider.sections[1].date.testFormat, dayTitle(in: 1))
		XCTAssertEqual(weekdayProvider.sections[1].todos[0].title, "Reise nach Paris planen")
		XCTAssertEqual(weekdayProvider.sections[1].todos[1].title, "Buch über Selbstverbesserung lesen")
		XCTAssertEqual(weekdayProvider.sections[1].todos[2].title, "Investitionsmöglichkeiten recherchieren")
		XCTAssertEqual(weekdayProvider.sections[1].todos[3].title, "Wochenendtrip in die Berge buchen")
		XCTAssertEqual(weekdayProvider.sections[2].date.testFormat, dayTitle(in: 2))
		XCTAssertEqual(weekdayProvider.sections[2].todos[0].title, "Wochenmenü planen und einkaufen")
		XCTAssertEqual(weekdayProvider.sections[2].todos[1].title, "Einkäufe für das Wochenende erledigen")
		XCTAssertEqual(weekdayProvider.sections[2].todos[2].title, "Arzttermin für Impfung vereinbaren")
		XCTAssertEqual(weekdayProvider.sections[3].date.testFormat, dayTitle(in: 3))
		XCTAssertEqual(weekdayProvider.sections[3].todos[0].title, "Keller entrümpeln und organisieren")
		XCTAssertEqual(weekdayProvider.sections[3].todos[1].title, "Fahrrad zur Reparatur bringen")
		XCTAssertEqual(weekdayProvider.sections[3].todos[2].title, "Mit dem Laufen beginnen")
		XCTAssertEqual(weekdayProvider.sections[4].date.testFormat, dayTitle(in: 4))
		XCTAssertEqual(weekdayProvider.sections[4].todos[0].title, "Wichtige Dokumente scannen und speichern")
		XCTAssertEqual(weekdayProvider.sections[4].todos[1].title, "Freunde zum Grillabend einladen")
		XCTAssertEqual(weekdayProvider.sections[4].todos[2].title, "Auto waschen und polieren")
		XCTAssertEqual(weekdayProvider.sections[5].date.testFormat, dayTitle(in: 5))
		XCTAssertEqual(weekdayProvider.sections[5].todos[0].title, "Yogaübungen für Entspannung durchführen")
		XCTAssertEqual(weekdayProvider.sections[5].todos[1].title, "Einen Tag nur für sich selbst planen")
		XCTAssertEqual(weekdayProvider.sections[5].todos[2].title, "Einen neuen Podcast entdecken und anhören")
		XCTAssertEqual(weekdayProvider.sections[6].date.testFormat, dayTitle(in: 6))
		XCTAssertEqual(weekdayProvider.sections[6].todos[0].title, "Frühjahrsputz in der Wohnung durchführen")
	}
	
	func test_CreateWeekdaysExcluded() throws {
		ExcludedDates.removeAll()
		ExcludedDates.add(date: .now)
		ExcludedDates.add(date: .now.addingTimeInterval(86400 * 3))

		let container = PersistentContainer(with: .testing)
		container.createDemoData()
		
		let weekdayProvider = PersistentTodoListProvider(persistentContainer: container)

		XCTAssertEqual(weekdayProvider.sections.count, 8)
		
		XCTAssertEqual(weekdayProvider.sections[0].isExcluded, true)
		XCTAssertEqual(weekdayProvider.sections[1].date.testFormat, dayTitle(in: 1))
		XCTAssertEqual(weekdayProvider.sections[1].todos[0].title, "Geburtstagsgeschenk für Mama besorgen")
		XCTAssertEqual(weekdayProvider.sections[1].todos[1].title, "Reise nach Paris planen")
		XCTAssertEqual(weekdayProvider.sections[1].todos[2].title, "Gartenarbeit - Pflanzen gießen und Unkraut jäten")
		XCTAssertEqual(weekdayProvider.sections[1].todos[3].title, "Buch über Selbstverbesserung lesen")
		XCTAssertEqual(weekdayProvider.sections[1].todos[4].title, "Neue Sprache lernen - Spanisch")
		XCTAssertEqual(weekdayProvider.sections[1].todos[5].title, "Investitionsmöglichkeiten recherchieren")
		XCTAssertEqual(weekdayProvider.sections[1].todos[6].title, "Wochenendtrip in die Berge buchen")
		XCTAssertEqual(weekdayProvider.sections[2].date.testFormat, dayTitle(in: 2))
		XCTAssertEqual(weekdayProvider.sections[2].todos[0].title, "Wochenmenü planen und einkaufen")
		XCTAssertEqual(weekdayProvider.sections[2].todos[1].title, "Einkäufe für das Wochenende erledigen")
		XCTAssertEqual(weekdayProvider.sections[2].todos[2].title, "Arzttermin für Impfung vereinbaren")
		XCTAssertEqual(weekdayProvider.sections[3].isExcluded, true)
		XCTAssertEqual(weekdayProvider.sections[4].date.testFormat, dayTitle(in: 4))
		XCTAssertEqual(weekdayProvider.sections[4].todos[0].title, "Keller entrümpeln und organisieren")
		XCTAssertEqual(weekdayProvider.sections[4].todos[1].title, "Fahrrad zur Reparatur bringen")
		XCTAssertEqual(weekdayProvider.sections[4].todos[2].title, "Mit dem Laufen beginnen")
		XCTAssertEqual(weekdayProvider.sections[5].date.testFormat, dayTitle(in: 5))
		XCTAssertEqual(weekdayProvider.sections[5].todos[0].title, "Wichtige Dokumente scannen und speichern")
		XCTAssertEqual(weekdayProvider.sections[5].todos[1].title, "Freunde zum Grillabend einladen")
		XCTAssertEqual(weekdayProvider.sections[5].todos[2].title, "Auto waschen und polieren")
		XCTAssertEqual(weekdayProvider.sections[6].date.testFormat, dayTitle(in: 6))
		XCTAssertEqual(weekdayProvider.sections[6].todos[0].title, "Yogaübungen für Entspannung durchführen")
		XCTAssertEqual(weekdayProvider.sections[6].todos[1].title, "Einen Tag nur für sich selbst planen")
		XCTAssertEqual(weekdayProvider.sections[6].todos[2].title, "Einen neuen Podcast entdecken und anhören")
		XCTAssertEqual(weekdayProvider.sections[7].date.testFormat, dayTitle(in: 7))
		XCTAssertEqual(weekdayProvider.sections[7].todos[0].title, "Frühjahrsputz in der Wohnung durchführen")
	}
	
	func dayTitle(in numberOfDays: Int) -> String {
		Date.now.addingTimeInterval(Double(numberOfDays) * 86400).testFormat
	}
}

private extension Date {
	var testFormat: String {
		self.formatted(.dateTime.year().month().day())
	}
}
