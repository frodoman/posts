//
//  ViewModel.swift
//  Models
//
//  Created by Xinghou Liu on 31/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation

public protocol ViewModel {
    func requestData()
}

public protocol ViewModelDelegate {
    func startWaiting()
    func stopWaiting()
    func updateUI(with error: Error?)
}

