//
//  PostsViewModelTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 10/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class PostsViewModelTest: XCTestCase {
    
    let mockDelegate = MockViewModelDelegate()
    
    lazy var viewModel: PostsViewModel = {
        let mockService = MockNetworkService()
        let mockStorage = DataManager(mockService)
        
        let model = PostsViewModel(mockStorage,
                                   delegate: mockDelegate,
                                   persistentManager: MockFullPersistent())
        return model
    }()
    
    func testRequestData() {
        self.viewModel.requestData { [weak self] in
            XCTAssertTrue(self?.mockDelegate.updateCalled ?? false)
            
            let (post, user, comments) = (self?.viewModel.allInformation(from: 0)!)!
            XCTAssertNotNil(post)
            XCTAssertNotNil(user)
            XCTAssertFalse(comments.isEmpty)
        }
    }
}
