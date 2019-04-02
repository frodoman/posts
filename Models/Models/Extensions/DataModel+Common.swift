//
//  DataModel+Common.swift
//  Models
//
//  Created by Xinghou Liu on 01/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

extension Array where Element == Post {
    public func post(with postId: Int) -> Post? {
        return self.first(where: {$0.id == postId})
    }
    
    public func posts(by authorId: Int) -> [Post] {
        return self.filter({$0.userId == authorId})
    }
}

extension Array where Element == User {
    public func user(with userId: Int) -> User? {
        return self.first(where: {$0.id == userId})
    }
}

extension Array where Element == Comment {
    public func comment(with commentId: Int) -> Comment? {
        return self.first(where: {$0.id == commentId})
    }
    
    public func comments(forPost postId: Int) -> [Comment] {
        return self.filter({$0.postId == postId})
    }
}
