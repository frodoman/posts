//
//  ModelsTests.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class PostModelTest: XCTestCase {

    func testDataModelParser() {
        guard let data = self.data(forJsonFile:"posts") else {
            XCTFail("No Json file for Post")
            return
        }
        
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            XCTAssertNotNil(posts)
            XCTAssertFalse(posts.isEmpty)
        }
        catch {
            XCTFail("Post decode failed: \(error)")
        }
    }
}
