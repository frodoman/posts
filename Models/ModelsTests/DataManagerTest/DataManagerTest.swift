//
//  StorageTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 26/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class DataManagerTest: XCTestCase {
    
    func testTetAllData() {
        let mockService = MockNetworkService()
        let mockStorage = DataManager(mockService)
        
        mockStorage.getAllData(from: MockBlankPersistent()) { ( posts, users, comments, error) in
            XCTAssertNotNil(error)
        }
        
        mockStorage.getAllData(from: MockFullPersistent()) { ( posts, users, comments, error) in
            XCTAssertNil(error)
            XCTAssertFalse(posts.isEmpty)
            XCTAssertFalse(users.isEmpty)
            XCTAssertFalse(comments.isEmpty)
        }
        
    }
    
    func testGetCacheData() {
        let mockService = MockNetworkService()
        let mockStorage = DataManager(mockService)

        mockStorage.getCacheData(from: MockBlankPersistent()) { ( posts, users, comments, error) in
            XCTAssertNotNil(error)
        }
        
        mockStorage.getCacheData(from: MockFullPersistent()) { ( posts, users, comments, error) in
            XCTAssertNil(error)
            XCTAssertFalse(posts.isEmpty)
            XCTAssertFalse(users.isEmpty)
            XCTAssertFalse(comments.isEmpty)
        }
    }
    
    func testGetLiveData() {
        let mockService = MockNetworkService()
        let mockStorage = DataManager(mockService)
        
        mockStorage.getLiveData { (posts, users, comments, error) in
            XCTAssertNotNil(error)
        }
        
        do {
            // mock post
            var jsonData = data(forJsonFile: "posts")!
            let postArray = try JSONDecoder().decode([Post].self, from: jsonData)
            mockService.postsResult = .succeed(postArray)
            mockStorage.getLiveData { (posts, users, comments, error) in
                XCTAssertFalse(posts.isEmpty)
                XCTAssertNotNil(error)
            }
            
            // mock users
            jsonData = data(forJsonFile: "users")!
            let userArray = try JSONDecoder().decode([User].self, from: jsonData)
            mockService.usersResult = .succeed(userArray)
            mockStorage.getLiveData { (posts, users, comments, error) in
                XCTAssertFalse(users.isEmpty)
                XCTAssertNotNil(error)
            }
            
            // mock comments
            jsonData = data(forJsonFile: "comments")!
            let commentArray = try JSONDecoder().decode([Comment].self, from: jsonData)
            mockService.commentResult = .succeed(commentArray)
            
            mockStorage.getLiveData { (posts, users, comments, error) in
                XCTAssertFalse(comments.isEmpty)
            }
        }
        catch {
            XCTFail()
        }
       
    }

}
