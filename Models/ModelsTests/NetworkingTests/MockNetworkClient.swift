//
//  MockNetworkClient.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 25/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
@testable import Models

final public class MockNetworkClient: NetworkClient {
    
    private let session: MockNetworkSession
    
    public init(session: MockNetworkSession = MockNetworkSession()) {
        self.session = session
    }
    
    public private(set) var urlRequests: [URLRequest] = []
    public var mockedResult: RequestResult<Data>?
    
    public func makeRequest(with request: URLRequest, completion: @escaping ((RequestResult<Data>) -> Void)) {
        
        urlRequests.append(request)
        
        guard let mockedResult = mockedResult else {
            print("No mocked result to return")
            return
        }
        
        completion(mockedResult)
    }
}
