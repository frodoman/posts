//
//  CacheFileManager.swift
//  Models
//
//  Created by Xinghou Liu on 27/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public enum PersistentFiles: String {
    case posts = "posts.dat"
    case users = "users.dat"
    case comments = "comments.dat"
}

public enum PersistentErrors: Error {
    case failedToSave
    case failedToRead
}

public protocol PersistentManager {
    func hasCached()  -> Bool
    func saveAll(posts:[Post], users: [User],comments: [Comment]) throws
    func getAll() throws -> ([Post], [User], [Comment])
    func clearAll() throws
}
