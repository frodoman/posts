//
//  MockViewModelDelegate.swift
//  ModelsTests
//
//  Created by Xinghou Liu on 10/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
@testable import Models

public final class MockViewModelDelegate:ViewModelDelegate {
    
    public var waiting: Bool = false
    public var updateCalled: Bool = false
    
    public func startWaiting() {
        self.waiting = true
    }
    
    public func stopWaiting() {
        self.waiting = false
    }
    
    public func updateUI(with error: Error?) {
        self.updateCalled = true
    }
}
