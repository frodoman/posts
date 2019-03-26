//
//  MockService.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 26/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
@testable import Models

public class MockService: DataService {
    
    public var postsResult: RequestResult<[Post]>?
    public var usersResult: RequestResult<[User]>?
    public var commentResult: RequestResult<[Comment]>?
    
    public let client: NetworkClient
    public let urlFactory: UrlFactory
    
    public init(client: NetworkClient = MockNetworkClient(),
                urlFactory: UrlFactory = MockUrlFactory()) {
        self.client = client
        self.urlFactory = urlFactory
    }
    
    public func getPosts(completion: @escaping (RequestResult<[Post]>) -> Void) {
        if let result = self.postsResult {
            completion(result)
        }
        else {
            completion(.failed(NetworkErrors.genaric))
        }
    }
    
    public func getUsers(completion: @escaping (RequestResult<[User]>) -> Void) {
        if let result = self.usersResult {
            completion(result)
        }
        else {
            completion(.failed(NetworkErrors.genaric))
        }
    }
    
    public func getComments(completion: @escaping (RequestResult<[Comment]>) -> Void) {
        if let result = self.commentResult {
            completion(result)
        }
        else {
            completion(.failed(NetworkErrors.genaric))
        }
    }
}
