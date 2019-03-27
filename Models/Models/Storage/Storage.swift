//
//  Storage.swift
//  Models
//
//  Created by Xinghou Liu on 26/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public typealias StorageCallBack = ([Post], [User], [Comment], Error?)->Void

public protocol DataService {
    func getPosts(completion: @escaping (RequestResult<[Post]>) -> Void)
    func getUsers(completion: @escaping (RequestResult<[User]>) -> Void)
    func getComments(completion: @escaping (RequestResult<[Comment]>) -> Void)
}

public class Storage {
    private let dataService: DataService
    private let fileManager: PersistentManager
    
    public init(_ service: DataService = NetworkService(),
                fileManager: PersistentManager = PersistentFileManager.shared) {
        self.dataService = service
        self.fileManager = fileManager
    }
    
    public func getAllData(completion: @escaping StorageCallBack) {
        let hasCached = self.fileManager.hasCached()
        
        if hasCached {
            getCacheData(completion: completion)
        }
        else {
            getLiveData(completion: completion)
        }
    }
    
    private func getCacheData(completion: @escaping StorageCallBack) {
        do {
            let posts: [Post] = try fileManager.get(from: .posts)
            let users: [User] = try fileManager.get(from: .users)
            let comments:[Comment] = try fileManager.get(from: .comments)
            completion(posts, users, comments, nil)
        }
        catch {
            completion([], [], [], error)
        }
    }
    
    private func getLiveData(completion: @escaping StorageCallBack) {
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
        dispatchGroup.notify(queue: .main) { [weak self] in
            PersistentFileManager.shared.saveAll(posts: posts,
                                      users: users,
                                      comments: comments)
            completion(posts, users, comments, error)
        }
    }
}
