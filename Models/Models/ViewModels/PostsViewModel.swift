//
//  PostsViewModel.swift
//  Posts
//
//  Created by Xinghou Liu on 01/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public typealias PostInformation = (Post, User?, [Comment])

public class PostsViewModel: NSObject, ViewModel {
    
    public let dataManager: DataManager
    public var delegate: ViewModelDelegate?
    public var persistentManager: PersistentManager
    
    public var posts: [Post] = []
    public var users: [User] = []
    public var comments: [Comment] = []
    
    public static let cellId = "PostTableCellId"
    
    public init(_ dataManager: DataManager = DataManager(),
                delegate: ViewModelDelegate? = nil,
                persistentManager: PersistentManager = FileManager.default) {
        self.dataManager = dataManager
        self.delegate = delegate
        self.persistentManager = persistentManager
    }
    
    public func requestData(completion: @escaping (()->Void)) {
        self.delegate?.startWaiting()
        self.dataManager.getAllData(from: self.persistentManager) { [weak self] (posts, users, comments, error) in
            self?.posts = posts
            self?.users = users
            self?.comments = comments
            self?.delegate?.updateUI(with: error)
            self?.delegate?.stopWaiting()
            completion()
        }
    }
    
    public func allInformation(from index: Int) -> PostInformation? {
        var postInfo: PostInformation?
        if index < self.posts.count {
            let post = self.posts[index]
            postInfo = self.authorAndComments(for: post)
        }
        return postInfo
    }
    
    public func authorAndComments(for post: Post) -> PostInformation {
        var user:User?
        if let author = self.users.user(with: post.userId) {
            user = author
        }
        let comments = self.comments.comments(forPost: post.id)
        return (post, user, comments)
    }
}
