//
//  UserModelTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class UserModelTest: XCTestCase {
    
    func testUserModelParser() {
        guard let data = self.data(forJsonFile:"users") else {
            XCTFail("No Json file for Users")
            return
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            XCTAssertNotNil(users)
            XCTAssertFalse(users.isEmpty)
        }
        catch {
            XCTFail("User decode failed: \(error)")
        }
    }
}
