//
//  UrlFactory.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol UrlFactory {
    func makePostsUrl() -> URL?
    func makeUsersUrl() -> URL?
    func makeCommentsUrl() -> URL?
}

public enum UrlPaths {
    public static let posts = "https://jsonplaceholder.typicode.com/posts"
    public static let users = "https://jsonplaceholder.typicode.com/users"
    public static let comments = "https://jsonplaceholder.typicode.com/comments"
}

public class LiveUrlFactory: UrlFactory {
    
    public init() {
        
    }
    
    public func makePostsUrl() -> URL? {
        return URL(string: UrlPaths.posts)
    }
    
    public func makeUsersUrl() -> URL? {
        return URL(string: UrlPaths.users)
    }
    
    public func makeCommentsUrl() -> URL? {
        return URL(string: UrlPaths.comments)
    }
}
