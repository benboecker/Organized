//
//  ObserverTests.swift
//  
//
//  Created by Benjamin Böcker on 28.02.24.
//

import XCTest
import Persistence
import CoreData




final class ObserverTests: XCTestCase {

	func testObserver() throws {
		let persistentContainer = PersistentContainer(with: .testing)
		let context = persistentContainer.mainContext
		let observer = ManagedObjectContextObserver<Tag>(
			context: context,
			sortBy: \.order
		)
		let exp = expectation(description: "testObserver")

		var counter = 1
		observer.didChangeObjects { tags in
			print("\(counter) - \(tags.count)")
			switch counter {
			case 1:
				XCTAssertEqual(tags.count, 1)
			case 2:
				XCTAssertEqual(tags.count, 2)
				exp.fulfill()
			default:
				break
			}
			
			counter += 1
		}
		
		let tag = Tag(context: context)
		tag.title = "New Tag"
		tag.colorHex = "#001122"
		tag.iconName = "house"
		tag.id = UUID()
		tag.order = 0
		
		try context.save()
		
		let tag2 = Tag(context: context)
		tag2.title = "New Tag 2"
		tag2.colorHex = "#AABBCC"
		tag2.iconName = "bookmark"
		tag2.id = UUID()
		tag2.order = 1
		
		try context.save()
		
		waitForExpectations(timeout: 10)
	}

}
