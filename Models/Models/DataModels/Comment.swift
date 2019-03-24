//
//  Comment.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public struct Comment: Codable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
}
