//
//  Bundle+Common.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public extension Bundle {
    
    public func data(forResource resourceName: String, withExtension resourceExtension: String) -> Data? {
        var foundData: Data?
        if let url = url(forResource: resourceName, withExtension: resourceExtension),
            let data = try? Data(contentsOf: url) {
            foundData = data
        }
        
        return foundData
    }
    
}
