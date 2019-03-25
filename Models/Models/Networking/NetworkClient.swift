//
//  NetworkClient.swift
//  Models
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol NetworkClient {
    func makeRequest(with request: URLRequest,
                     completion: @escaping (RequestResult<(Data)>) -> Void)
}

public enum NetworkErrors: Error {
    case genaric
    case unexpectedResponse
    case emptyResponse
    case wrongUrlFormat
}

public class DefaultNetworkClient: NetworkClient {
    
    public let session: NetworkSession
    
    public init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    public func makeRequest(with request: URLRequest,
                            completion: @escaping (RequestResult<(Data)>) -> Void) {
        session.startDataTask(with: request,
                              completionHandler: { (data, response, error) -> Void in
                                
                                if let error = error {
                                    completion(.failed(error))
                                    return
                                }
                                
                                guard let data = data else {
                                    completion(.failed(NetworkErrors.emptyResponse))
                                    return
                                }
                                
                                completion(.succeed(data))
        })
    }
}
