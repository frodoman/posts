//
//  XCUITest+Common.swift
//  PostsUITests
//
//  Created by Xinghou Liu on 02/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    public func waitForElement(element: XCUIElement,
                               toAppear: Bool,
                               file: String = #file,
                               line: UInt = #line) {
        var existsPredicate = NSPredicate(format: "exists == false")
        if toAppear {
            existsPredicate = NSPredicate(format: "exists == true")
        }
        let expectation = self.expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 10) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 10 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
            else {
                expectation.fulfill()
            }
        }
    }
    
    func scrollToElement(element: XCUIElement)
    {
        while element.visible() == false
        {
            let app = XCUIApplication()
            let startCoord = app.collectionViews.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let endCoord = startCoord.withOffset(CGVector(dx: 0.0, dy: -262));
            startCoord.press(forDuration: 0.01, thenDragTo: endCoord)
        }
    }
    
    public func enter(key: String) {
        guard key.count == 1 else { return }
        let aKey = XCUIApplication().keys[key]
        aKey.tap()
    }
}


extension XCUIElement {
    public func visible() -> Bool
    {
        guard self.exists && self.isHittable && !self.frame.isEmpty else
        {
            return false
        }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
