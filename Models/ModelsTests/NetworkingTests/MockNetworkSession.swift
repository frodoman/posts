//
//  MockNetworkSession.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
@testable import Models

final public class MockNetworkSession: NSObject, NetworkSession {
    
    public var completionResult: (Data?, URLResponse?, Error?)?
    
    public func startDataTask(with request: URLRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let completionResult = completionResult {
            completionHandler(completionResult.0, completionResult.1, completionResult.2)
        }
        
        return URLSessionDataTask()
    }
}
