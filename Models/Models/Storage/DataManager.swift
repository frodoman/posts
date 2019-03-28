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

public class DataManager {
    private let dataService: DataService
    
    public init(_ service: DataService = NetworkService()) {
        self.dataService = service
    }
    
    public func getAllData(from persistentManager: PersistentManager = FileManager.default,
                           completion: @escaping StorageCallBack) {
        let hasCached = persistentManager.hasCached()
        
        if hasCached {
            getCacheData(from: persistentManager, completion: completion)
        }
        else {
            getLiveData(with: persistentManager, completion: completion)
        }
    }
    
    public func getCacheData(from persistentManager:PersistentManager = FileManager.default,
                             completion: @escaping StorageCallBack) {
        do {
            let (posts, users, comments) = try persistentManager.getAll()
            completion(posts, users, comments, nil)
        }
        catch {
            completion([], [], [], error)
        }
    }
    
    public func getLiveData(with persistentManager:PersistentManager = FileManager.default,
                            completion: @escaping StorageCallBack) {
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
            try? persistentManager.saveAll(posts: posts, users: users, comments: comments)
            completion(posts, users, comments, error)
        }
    }
}
