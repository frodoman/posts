//
//  Storage.swift
//  Models
//
//  Created by Xinghou Liu on 26/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol DataService {
    func getPosts(completion: @escaping (RequestResult<[Post]>) -> Void)
    func getUsers(completion: @escaping (RequestResult<[User]>) -> Void)
    func getComments(completion: @escaping (RequestResult<[Comment]>) -> Void)
}

public class Storage {
    private let dataService: DataService
    
    public init(_ service: DataService = NetworkService()) {
        self.dataService = service
    }
    
    public func getLiveData(completion: @escaping ([Post], [User], [Comment], Error?)->Void) {
        let dispatchGroup = DispatchGroup()
        
        var posts: [Post] = []
        var users: [User] = []
        var comments: [Comment] = []
        
        var error: Error?
        dispatchGroup.enter()
        dataService.getPosts { (result) in
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
            dataService.getUsers { (result) in
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
            dataService.getComments { (result) in
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
}
