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

public protocol PersistentManager {
    func hasCached() -> Bool
    func saveAll(posts:[Post], users: [User],comments: [Comment])
    func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws
    func get<DataType: Decodable>(from fileName: PersistentFiles) throws -> [DataType]
}

public class PersistentFileManager: PersistentManager {
    
    public init () {
        
    }
    
    public func hasCached() -> Bool {
        return hasCache(for: .comments) &&
               hasCache(for: .posts) &&
               hasCache(for: .users)
    }
    
    public func hasCache(for fileName: PersistentFiles) -> Bool {
        var isExist = false
        if let filePath = fileUrl(with: fileName)?.path {
            isExist = FileManager.default.fileExists(atPath: filePath)
        }
        return isExist
    }
    
    public func saveAll( posts:[Post],
                         users: [User],
                         comments: [Comment]) {
        try? self.save(from: posts, to: .posts)
        try? self.save(from: users, to: .users)
        try? self.save(from: comments, to: .comments)
    }
    
    public func save<DataType: Encodable>(from objects: [DataType], to fileName: PersistentFiles) throws {
        if let url = fileUrl(with: fileName) {
            let data = try JSONEncoder().encode(objects)
            try data.write(to: url, options: .atomic)
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
    
    private func fileUrl(with name: PersistentFiles) -> URL? {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return dir?.appendingPathComponent(name.rawValue)
    }
}
