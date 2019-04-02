//
//  PostsUITests.swift
//  PostsUITests
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
import Models

class PostsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPosts() {
        let app = XCUIApplication()
        let tableView = app.tables[AccessibilityIDs.mainTableView]
        
        // data has been loaded
        if tableView.exists {
            self.testWithPersistentData(with: app)
        }
        // first time runing
        else {
            self.testWithLiveData(with: app,
                                  talbView: tableView)
        }
    }

    func testWithPersistentData(with app: XCUIApplication) {
        // make sure first cell is exists
        let firstCell = app.cells[AccessibilityIDs.mainTableViewCell + ".0"]
        XCTAssertTrue(firstCell.exists)
        
        // tap on first cell
        firstCell.tap()
        let title = app.staticTexts[AccessibilityIDs.detailsTitle]
        waitForElement(element: title, toAppear: true)
        
        // title & body are exists
        XCTAssertTrue(title.exists)
        let body = app.staticTexts[AccessibilityIDs.detailsBody]
        XCTAssertTrue(body.exists)
        
        // go back to the post list
        app.navigationBars["Details"].buttons["Posts"].tap()
        app.swipeUp()
        let cell = app.cells[AccessibilityIDs.mainTableViewCell + ".6"]
        XCTAssertTrue(cell.exists)
    }
    
    func testWithLiveData(with app: XCUIApplication,
                          talbView: XCUIElement) {
        waitForElement(element: talbView, toAppear: true)
        XCTAssertTrue(talbView.exists)
        
        self.testWithPersistentData(with: app)
    }
}
