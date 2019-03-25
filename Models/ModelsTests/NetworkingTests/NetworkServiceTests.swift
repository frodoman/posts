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
        let service = NetworkService(client: client)
        
        if let url = url(forJsonFile: "search-result-response-hello-normal") {
            
            let request = URLRequest(url: url)
            let localdataExpectation = expectation(description: "Should Return local data")
            
            service.getSearchResult(with: request) { (result) in
                switch result {
                case .failed( let error):
                    XCTFail("Failed to load local data : \(error)")
                case .succeed(let searchResponse):
                    XCTAssertNotNil(searchResponse.results.attr)
                }
                localdataExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }
    
}
