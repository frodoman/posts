//
//  MockUrlFactory.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

public class MockUrlFactory: XCTestCase, UrlFactory {
    
    public func makePostsUrl() -> String {
        var urlPath = ""
        if let urlText = url(forJsonFile: "posts") {
            urlPath = urlText
        }
        return urlPath
    }
    
    public func makeUsersUrl() -> String {
        let urlText = url(forJsonFile: "users")
        return urlText ?? ""
    }
    
    public func makeCommentsUrl() -> String {
        return UrlPaths.comments
    }
}
