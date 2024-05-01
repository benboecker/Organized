import XCTest
@testable import TodoListData
import Persistence


final class WeekdayProviderTest: XCTestCase {
	
	func test_CreateWeekdaysInitially() throws {
		
		let container = PersistentContainer(with: .testing)
		container.createDemoData()
		
		let weekdayProvider = PersistentWeekdayProvider(persistentContainer: container)
		
		XCTAssertEqual(weekdayProvider.weekdays.count, 7)
		XCTAssertEqual(weekdayProvider.weekdays.reduce(0) { $0 + $1.todos.count }, 19)
	}
}
