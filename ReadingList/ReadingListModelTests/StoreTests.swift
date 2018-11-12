// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
@testable import ReadingListModel

class StoreTests: XCTestCase {
    let store = ReadingListStore()
    
    override func setUp() {
        super.setUp()
        print()
    }

    override func tearDown() {
        print()
        super.tearDown()
    }
    
    func testFetchReadingList() {
        let readingList = store.fetch()
        print(readingList)
        XCTAssertNotNil(readingList)
    }
}
