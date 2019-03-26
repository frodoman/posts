//
//  NetworkService.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public class NetworkService: ResponseHandler {
    public typealias ResponseType = [Post]
    public typealias UsersResponseType = [User]
    public typealias CommentResponseType = [Comment]
    
    private let urlFactory: UrlFactory
    private let client: NetworkClient
    
    public init(client: NetworkClient = DefaultNetworkClient(),
                urlFactory: UrlFactory = LiveUrlFactory()) {
        self.client = client
        self.urlFactory = urlFactory
    }
    
    public func getAllInfo(completion: @escaping ([Post], [User], [Comment], Error?)->Void) {
        let dispatchGroup = DispatchGroup()
        
        var posts: [Post] = []
        var users: [User] = []
        var comments: [Comment] = []
        
        var error: Error?
        dispatchGroup.enter()
        self.getPosts { (result) in
            switch result {
            case .succeed(let postArray):
                posts = postArray
            case .failed(let postError):
                error = postError
            }
            dispatchGroup.leave()
        }
        
        if error == nil {
            dispatchGroup.enter()
            self.getUsers { (result) in
                switch result {
                case .succeed(let userArray):
                    users = userArray
                case .failed(let  userError):
                    error = userError
                }
                dispatchGroup.leave()
            }
        }

        if error == nil {
            dispatchGroup.enter()
            self.getComments { (result) in
                switch result {
                case .succeed(let commentArray):
                    comments = commentArray
                case .failed(let  commentError):
                    error = commentError
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(posts, users, comments, error)
        }
    }
    
    public func getPosts(completion: @escaping (RequestResult<ResponseType>) -> Void) {
        if let request = self.urlRequest(for:  urlFactory.makePostsUrl()) {
            self.client.makeRequest(with: request) { (result) in
                do {
                    let searchResponse: RequestResult<ResponseType> = .succeed(try self.decodeResponse(response: result))
                    completion(searchResponse)
                }
                catch {
                    completion(.failed(error))
                }
            }
        }
    }
    
    public func getUsers(completion: @escaping (RequestResult<UsersResponseType>) -> Void) {
        if let request = self.urlRequest(for:  urlFactory.makeUsersUrl()) {
            self.client.makeRequest(with: request) { (result) in
                do {
                    let users: RequestResult<UsersResponseType> = .succeed(try self.decodeResponse(response: result))
                    completion(users)
                }
                catch {
                    completion(.failed(error))
                }
            }
        }
    }

    public func getComments(completion: @escaping (RequestResult<CommentResponseType>) -> Void) {
        if let request = self.urlRequest(for:  urlFactory.makeCommentsUrl()) {
            self.client.makeRequest(with: request) { (result) in
                do {
                    let comments: RequestResult<CommentResponseType> = .succeed(try self.decodeResponse(response: result))
                    completion(comments)
                }
                catch {
                    completion(.failed(error))
                }
            }
        }
    }
    
    private func urlRequest(for url: URL?) -> URLRequest? {
        var request: URLRequest?
        if let url = url {
            request = URLRequest(url: url)
        }
        return request
    }
}
