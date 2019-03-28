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
    
    func hasCache(for fileName: PersistentFiles) -> Bool
    func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws
    func delete(fileName: PersistentFiles) throws
    func get<DataType: Decodable>(from fileName: PersistentFiles) throws -> [DataType]
    func fileUrl(with name: PersistentFiles) -> URL?
}

extension FileManager: PersistentManager {
    
    // MARK: - Public
    public func hasCached() -> Bool {
        return hasCache(for: .comments) &&
               hasCache(for: .posts) &&
               hasCache(for: .users)
    }
    
    public func saveAll( posts:[Post],
                         users: [User],
                         comments: [Comment]) throws {
        if !hasCached() {
            try self.save(from: posts, to: .posts)
            try self.save(from: users, to: .users)
            try self.save(from: comments, to: .comments)
        }
    }
    
    public func getAll() throws -> ([Post], [User], [Comment]){
        let posts: [Post] = try self.get(from: .posts)
        let users: [User] = try self.get(from: .users)
        let comments: [Comment] = try self.get(from: .comments)
        return (posts, users, comments)
    }
    
    public func clearAll() throws {
        try self.delete(fileName: .users)
        try self.delete(fileName: .posts)
        try self.delete(fileName: .comments)
    }
    
    //MARK: - Private
    public func hasCache(for fileName: PersistentFiles) -> Bool {
        var isExist = false
        if let filePath = fileUrl(with: fileName)?.path {
            isExist = FileManager.default.fileExists(atPath: filePath)
        }
        return isExist
    }
    
    public func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws {
        if let url = fileUrl(with: fileName) {
            let data = try JSONEncoder().encode(objects)
            try data.write(to: url, options: .atomic)
        }
    }
    
    public func delete(fileName: PersistentFiles) throws {
        if let url = fileUrl(with: fileName) {
            try self.removeItem(at: url)
        }
    }
    
    public func get<DataType: Decodable>(from fileName: PersistentFiles) throws -> [DataType] {
        var objects: [DataType] = []
        
        if let url = fileUrl(with: fileName) {
            let data = try Data(contentsOf: url)
            let objectArray = try JSONDecoder().decode([DataType].self, from: data)
            objects = objectArray
        }
        return objects
    }
    
    public func fileUrl(with name: PersistentFiles) -> URL? {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return dir?.appendingPathComponent(name.rawValue)
    }
}
