//
//  MockUrlFactory.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
@testable import Models

public class MockUrlFactory: UrlFactory {
    
    public init() {
        
    }
    
    public func makePostsUrl() -> URL? {
       return pathForJson(name: "posts")
    }
    
    public func makeUsersUrl() -> URL? {
        return pathForJson(name: "users")
    }
    
    public func makeCommentsUrl() -> URL? {
        return pathForJson(name: "comments")
    }
    
    private func pathForJson(name fileName: String) -> URL? {
        var urlPath: URL?
        if let url = Bundle(for: type(of: self).self).url(forResource: fileName, withExtension: "json") {
            urlPath = url
        }
        return urlPath
    }
}
