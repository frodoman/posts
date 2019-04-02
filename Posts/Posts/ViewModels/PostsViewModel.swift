//
//  PostsViewModel.swift
//  Posts
//
//  Created by Xinghou Liu on 01/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import Models

public typealias PostInformation = (Post, User?, [Comment])

public class PostsViewModel: NSObject, ViewModel {
    
    public let dataManager: DataManager
    public var delegate: ViewModelDelegate?
    
    public var posts: [Post] = []
    public var users: [User] = []
    public var comments: [Comment] = []
    
    public static let cellId = "PostTableCellId"
    
    public init(_ dataManager: DataManager = DataManager(),
                delegate: ViewModelDelegate? = nil) {
        self.dataManager = dataManager
        self.delegate = delegate
    }
    
    public func requestData() {
        self.delegate?.startWaiting()
        self.dataManager.getAllData { [weak self] (posts, users, comments, error) in
            self?.posts = posts
            self?.users = users
            self?.comments = comments
            self?.delegate?.updateUI(with: error)
            self?.delegate?.stopWaiting()
        }
    }
    
    public func allInformation(from index: Int) -> PostInformation? {
        var postInfo: PostInformation?
        if index < self.posts.count {
            let post = self.posts[index]
            postInfo = self.allInformation(for: post)
        }
        return postInfo
    }
    
    public func allInformation(for post: Post) -> PostInformation {
        var user:User?
        if let author = self.users.user(with: post.userId) {
            user = author
        }
        let comments = self.comments.comments(forPost: post.id)
        return (post, user, comments)
    }
}
