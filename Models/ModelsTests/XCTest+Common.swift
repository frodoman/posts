//
//  XCTest+Common.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import XCTest
//import Foundation
@testable import Models

extension XCTestCase {
    func url(forJsonFile fileName: String) -> URL? {
        return Bundle(for: type(of: self).self).url(forResource: fileName, withExtension: "json")
    }
    
    func data(forJsonFile fileName: String) -> Data? {
        return Bundle(for: type(of: self).self).data(forResource: fileName, withExtension: "json")
    }
}
