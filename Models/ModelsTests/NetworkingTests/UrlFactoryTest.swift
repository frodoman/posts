//
//  UrlFactoryTest.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

final class UrlFactoryTest: XCTestCase {
    
    func testLiveUrls() {
        let urlFactory = LiveUrlFactory()
        
        XCTAssertNotNil(urlFactory.makeCommentsUrl())
        XCTAssertNotNil(urlFactory.makePostsUrl())
        XCTAssertNotNil(urlFactory.makeUsersUrl())
    }

}
