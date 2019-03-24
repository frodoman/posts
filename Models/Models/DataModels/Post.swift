//
//  Post.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public struct Post: Codable {
    public let id: Int
    public let userId: Int
    public let title: String
    public let body: String
}

