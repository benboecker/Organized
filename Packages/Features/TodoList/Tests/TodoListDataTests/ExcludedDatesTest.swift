import XCTest
@testable import TodoListData



final class ExcludedDatesTest: XCTestCase {
    func testExample() throws {
		
		ExcludedDates.add(date: .now)
		
		XCTAssertTrue(ExcludedDates.contains(.now))
		XCTAssertFalse(ExcludedDates.contains(.now.addingTimeInterval(86_400)))

		ExcludedDates.remove(date: .now)
	}
}
