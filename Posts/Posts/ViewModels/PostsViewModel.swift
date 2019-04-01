//
//  PostsViewModel.swift
//  Posts
//
//  Created by Xinghou Liu on 01/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import Models

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
}
