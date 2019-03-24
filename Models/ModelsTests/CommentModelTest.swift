//
//  CommentModelTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

class CommentModelTest: XCTestCase {
    
    func testCommentModelParser() {
        guard let data = self.data(forJsonFile:"comments") else {
            XCTFail("No Json file for Comments")
            return
        }
        
        do {
            let comments = try JSONDecoder().decode([Comment].self, from: data)
            XCTAssertNotNil(comments)
            XCTAssertFalse(comments.isEmpty)
        }
        catch {
            XCTFail("Comments decode failed: \(error)")
        }
    }
}
