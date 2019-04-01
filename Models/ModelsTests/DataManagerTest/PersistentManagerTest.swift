//
//  PersistentManagerTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 28/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class PersistentManagerTest: XCTestCase {
    
    override func tearDown() {
         try? FileManager.default.clearAll()
    }
    
    func testClearAll() {
        do {
            try FileManager.default.clearAll()
            XCTAssertFalse(FileManager.default.hasCached())
        }
        catch {
            
        }
    }
    
    func testSaveAll() {
        do {
            try FileManager.default.clearAll()
            try FileManager.default.saveAll(posts: XCTestCase.mockPosts(),
                                            users: XCTestCase.mockUsers(),
                                            comments: XCTestCase.mockComments())
            let (posts, users, comments) = try FileManager.default.getAll()
            
            XCTAssertFalse(posts.isEmpty)
            XCTAssertFalse(users.isEmpty)
            XCTAssertFalse(comments.isEmpty)
        }
        catch {
        }
    }
}

extension FileManager {
    private func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws {
        
        print("Saving...")
    }
    
    private func get<DataType: Decodable>(from fileName: PersistentFiles) throws -> [DataType]  {
        let array: [DataType] = []
        return array
    }
}
