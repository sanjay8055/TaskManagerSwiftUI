//
//  TaskManagerUITests.swift
//  TaskManagerUITests
//
//  Created by Sanjay Raskar on 10/01/25.
//

import XCTest

final class TaskManagerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().navigationBars["Tasks List"].buttons["Sort"].tap()
        
        let collectionViewsQuery = app.collectionViews
        if collectionViewsQuery.children(matching: .cell).count > 2 {
            let reorderButton = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons["Reorder"]
            reorderButton.press(forDuration: 1.1)
            reorderButton.swipeDown()
            app.navigationBars["Tasks List"]/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".otherElements[\"Done\"].buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        app.buttons["New Task"].tap()
        collectionViewsQuery.textFields["Enter task title"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
