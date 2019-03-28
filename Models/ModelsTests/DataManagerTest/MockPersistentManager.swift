//
//  MockPersistentManager.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 28/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import XCTest
@testable import Models

public class MockBlankPersistent: PersistentManager {
    public func hasCache(for fileName: PersistentFiles) -> Bool {
        return false
    }
    
    public func save<DataType>(from objects: [DataType], to fileName: PersistentFiles) throws where DataType : Encodable {
        
    }
    
    public func delete(fileName: PersistentFiles) throws {
        
    }
    
    public func get<DataType>(from fileName: PersistentFiles) throws -> [DataType] where DataType : Decodable {
        return []
    }
    
    public func fileUrl(with name: PersistentFiles) -> URL? {
        return nil
    }
    
    public func hasCached() -> Bool {
        return false
    }
    
    public func saveAll(posts: [Post], users: [User], comments: [Comment]) throws {
         throw PersistentErrors.failedToSave
    }
    
    public func getAll() throws -> ([Post], [User], [Comment]) {
        throw PersistentErrors.failedToRead
    }
    
    public func clearAll() throws {
        throw PersistentErrors.failedToRead
    }
}

public class MockFullPersistent: PersistentManager {
    public func hasCache(for fileName: PersistentFiles) -> Bool {
        return true
    }
    
    public func save<DataType>(from objects: [DataType], to fileName: PersistentFiles) throws where DataType : Encodable {
        
    }
    
    public func delete(fileName: PersistentFiles) throws {
        
    }
    
    public func get<DataType>(from fileName: PersistentFiles) throws -> [DataType] where DataType : Decodable {
        return []
    }
    
    public func fileUrl(with name: PersistentFiles) -> URL? {
        return URL(string: "https://www.google.com")
    }
    
    public func hasCached() -> Bool {
        return true
    }
    
    public func saveAll(posts: [Post], users: [User], comments: [Comment]) throws {
        
    }
    
    public func getAll() throws -> ([Post], [User], [Comment]) {
        return (XCTestCase.mockPosts(),
                XCTestCase.mockUsers(),
                XCTestCase.mockComments())
    }
    
    public func clearAll() throws {

    }
}

extension XCTestCase {
    public static func mockPosts() -> [Post] {
        let posts = [Post(id: 0, userId: 0, title: "1", body: "body 1")]
        return posts
    }
    
    public static func mockUsers() -> [User] {
        let fakeLocation = GeoLocation(lat: "1", lng: "2")
        let fakeAddress = Address(street: "A", suite: "B", city: "C", zipcode: "D", geo: fakeLocation)
        let fakeCompany = Company(name: "Apple", catchPhrase: "E", bs: "F")
        let users = [User(id: 0, name: "A", email: "B", address: fakeAddress, phone: "009", website: "www.bbc.com", company:fakeCompany)]
        return users
    }
    
    public static func mockComments() -> [Comment] {
        let comments = [Comment(postId: 0, id: 0, name: "Post", email: "comment email", body: "comment body")]
        return comments
    }
}
