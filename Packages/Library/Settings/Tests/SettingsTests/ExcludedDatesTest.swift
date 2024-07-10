import XCTest
@testable import Settings


final class ExcludedDatesTest: XCTestCase {
	
	override func setUp() {
		ExcludedDates.shared.removeAll()
	}
	
    func testExcludeManually() throws {
		ExcludedDates.shared.toggleManuallyExclude(date: .now)
		XCTAssertEqual(ExcludedDates.shared.isDateExcluded(.now), .manually)
	}
	
	override func tearDown() {
		ExcludedDates.shared.removeAll()
	}
}
