//
//  UrlFactory.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol UrlFactory {
    func makePostsUrl() -> String
    func makeUsersUrl() -> String
    func makeCommentsUrl() -> String
}

public enum UrlPaths {
    public static let posts = "https://jsonplaceholder.typicode.com/posts"
    public static let users = "https://jsonplaceholder.typicode.com/users"
    public static let comments = "https://jsonplaceholder.typicode.com/comments"
}

public class LiveUrlFactory: UrlFactory {
    
    public init() {
        
    }
    
    public func makePostsUrl() -> String {
        return UrlPaths.posts
    }
    
    public func makeUsersUrl() -> String {
        return UrlPaths.users
    }
    
    public func makeCommentsUrl() -> String {
        return UrlPaths.comments
    }
}
