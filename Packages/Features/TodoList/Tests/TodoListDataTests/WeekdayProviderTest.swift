import XCTest
@testable import TodoListData
import Persistence


final class WeekdayProviderTest: XCTestCase {
	
	func test_CreateWeekdaysInitially() throws {
		
		let container = PersistentContainer(with: .testing)
		container.createDemoData()
		
		let weekdayProvider = PersistentTodoListProvider(persistentContainer: container)
				
		XCTAssertEqual(weekdayProvider.entries.count, 27)
		
//		guard weekdayProvider.entries.count == 27 else {
//			for entry in weekdayProvider.entries {
//				print(entry.title)
//			}
////			return
//		}
		
		XCTAssertEqual(weekdayProvider.entries[0].title, dayTitle(in: 0))
		XCTAssertEqual(weekdayProvider.entries[1].title, "Geburtstagsgeschenk für Mama besorgen")
		XCTAssertEqual(weekdayProvider.entries[2].title, "Gartenarbeit - Pflanzen gießen und Unkraut jäten")
		XCTAssertEqual(weekdayProvider.entries[3].title, "Neue Sprache lernen - Spanisch")
		XCTAssertEqual(weekdayProvider.entries[4].title, dayTitle(in: 1))
		XCTAssertEqual(weekdayProvider.entries[5].title, "Reise nach Paris planen")
		XCTAssertEqual(weekdayProvider.entries[6].title, "Buch über Selbstverbesserung lesen")
		XCTAssertEqual(weekdayProvider.entries[7].title, "Investitionsmöglichkeiten recherchieren")
		XCTAssertEqual(weekdayProvider.entries[8].title, "Wochenendtrip in die Berge buchen")
		XCTAssertEqual(weekdayProvider.entries[9].title, dayTitle(in: 2))
		XCTAssertEqual(weekdayProvider.entries[10].title, "Wochenmenü planen und einkaufen")
		XCTAssertEqual(weekdayProvider.entries[11].title, "Einkäufe für das Wochenende erledigen")
		XCTAssertEqual(weekdayProvider.entries[12].title, "Arzttermin für Impfung vereinbaren")
		XCTAssertEqual(weekdayProvider.entries[13].title, dayTitle(in: 3))
		XCTAssertEqual(weekdayProvider.entries[14].title, "Keller entrümpeln und organisieren")
		XCTAssertEqual(weekdayProvider.entries[15].title, "Fahrrad zur Reparatur bringen")
		XCTAssertEqual(weekdayProvider.entries[16].title, "Mit dem Laufen beginnen")
		XCTAssertEqual(weekdayProvider.entries[17].title, dayTitle(in: 4))
		XCTAssertEqual(weekdayProvider.entries[18].title, "Wichtige Dokumente scannen und speichern")
		XCTAssertEqual(weekdayProvider.entries[19].title, "Freunde zum Grillabend einladen")
		XCTAssertEqual(weekdayProvider.entries[20].title, "Auto waschen und polieren")
		XCTAssertEqual(weekdayProvider.entries[21].title, dayTitle(in: 5))
		XCTAssertEqual(weekdayProvider.entries[22].title, "Yogaübungen für Entspannung durchführen")
		XCTAssertEqual(weekdayProvider.entries[23].title, "Einen Tag nur für sich selbst planen")
		XCTAssertEqual(weekdayProvider.entries[24].title, "Einen neuen Podcast entdecken und anhören")
		XCTAssertEqual(weekdayProvider.entries[25].title, dayTitle(in: 6))
		XCTAssertEqual(weekdayProvider.entries[26].title, "Frühjahrsputz in der Wohnung durchführen")
	}
	
	func dayTitle(in numberOfDays: Int) -> String {
		Date.now.addingTimeInterval(Double(numberOfDays) * 86400).formatted(.dateTime.weekday(.wide).day().month())
	}
}
