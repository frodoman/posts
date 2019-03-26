//
//  NetworkServiceTests.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class NetworkServiceTests: XCTestCase {
    
    //MARK: - Posts
    func testGetPostsNormal() {
        
        let mockClient = MockNetworkClient(session: MockNetworkSession())
        let service = NetworkService(client: mockClient)
        
        let jsonData = data(forJsonFile: "posts")!
        mockClient.mockedResults = [.succeed(jsonData)]
        
        service.getPosts { (result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get posts: \(error)")
            case .succeed(let postResponse):
                XCTAssertNotNil(postResponse)
                XCTAssertFalse(postResponse.isEmpty)
            }
        }
        
        mockClient.mockedResults = [.failed(NetworkErrors.genaric)]
        service.getPosts { (result) in
            switch result {
            case .failed( let error):
                XCTAssertNotNil(error)
            case .succeed(let postResponse):
                XCTFail("Should be nil but got: \(postResponse)")
            }
        }
    }
    
    func testGetPostsErrorHandler() {
        let mockClient = MockNetworkClient(session: MockNetworkSession())
        let service = NetworkService(client: mockClient)
        
        let jsonData = data(forJsonFile: "posts_error")!
        mockClient.mockedResults = [.succeed(jsonData)]
        
        service.getPosts { (result) in
            switch result {
            case .failed( let error):
                XCTAssertNotNil(error)
            case .succeed(let postResponse):
                XCTFail("Should be nil but got: \(postResponse)")
            }
        }
    }

    func testGetPostsWithLocalData() {
        let client = DefaultNetworkClient()
        let service = NetworkService(client: client,
                                     urlFactory: MockUrlFactory())
        
        let localdataExpectation = expectation(description: "Should Return local data")
        service.getPosts { (result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get posts: \(error)")
            case .succeed(let postResponse):
                XCTAssertNotNil(postResponse)
                XCTAssertFalse(postResponse.isEmpty)
            }
            localdataExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    //MARK: - Users
    func testGetUsersNormal() {
        let mockClient = MockNetworkClient(session: MockNetworkSession())
        let service = NetworkService(client: mockClient)
        
        let jsonData = data(forJsonFile: "users")!
        mockClient.mockedResults = [.succeed(jsonData)]
        
        service.getUsers { (result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get users: \(error)")
            case .succeed(let users):
                XCTAssertNotNil(users)
                XCTAssertFalse(users.isEmpty)
            }
        }
    }
    
    //MARK: - Comments
    func testGetCommentsNormal() {
        let mockClient = MockNetworkClient(session: MockNetworkSession())
        let service = NetworkService(client: mockClient)
        
        let jsonData = data(forJsonFile: "comments")!
        mockClient.mockedResults = [.succeed(jsonData)]
        
        service.getComments { (result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get comments: \(error)")
            case .succeed(let comments):
                XCTAssertNotNil(comments)
                XCTAssertFalse(comments.isEmpty)
            }
        }
    }
    
    //MARK: -
    func testDefaultNetworkClientWithMockSession() {
        
        let mockSession = MockNetworkSession()
        let client = DefaultNetworkClient(session: mockSession)
        let service = NetworkService(client: client)
        
        if let responseData = data(forJsonFile: "posts") {
            
            mockSession.completionResult = (responseData, URLResponse(), nil)
            
            service.getPosts { (result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let posts):
                    XCTAssertNotNil(posts)
                }
            }
            
            mockSession.completionResult = (nil, URLResponse(), NetworkErrors.genaric)
            service.getPosts { (result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let posts):
                    XCTFail("Should be nil but got: \(posts)")
                }
            }
            
            mockSession.completionResult = (nil, URLResponse(), nil)
            service.getPosts { (result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let posts):
                    XCTFail("Should be nil but got: \(posts)")
                }
            }
        }
    }
}
