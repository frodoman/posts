//
//  NetworkSession.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol NetworkSession {
    @discardableResult
    func startDataTask(with request: URLRequest,
                       completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {
    
    @discardableResult
    public func startDataTask(with request: URLRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let dataTask = self.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
        return dataTask
    }
}
