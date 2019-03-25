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
    
    func testGetPostsNormal() {
        
        let mockClient = MockNetworkClient(session: MockNetworkSession())
        let service = NetworkService(client: mockClient)
        
        let jsonData = data(forJsonFile: "posts")!
        mockClient.mockedResult = .succeed(jsonData)
        
        service.getPosts { (result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get posts: \(error)")
            case .succeed(let postResponse):
                XCTAssertNotNil(postResponse)
                XCTAssertFalse(postResponse.isEmpty)
            }
        }
        
        mockClient.mockedResult = .failed(NetworkErrors.genaric)
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
        mockClient.mockedResult = .succeed(jsonData)
        
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
