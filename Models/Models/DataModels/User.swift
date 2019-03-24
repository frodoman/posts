//
//  User.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public struct Address: Codable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geo: GeoLocation
}

public struct GeoLocation: Codable {
    public let lat: String
    public let lng: String
}

public struct Company: Codable {
    public let name: String
    public let catchPhrase: String
    public let bs: String
}

public struct User: Codable {
    public let id: Int
    public let name: String
    public let email: String
    public let address: Address
    public let phone: String
    public let website: String
    public let company: Company
}
