//
//  BaseViewController.swift
//  Posts
//
//  Created by Xinghou Liu on 31/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import UIKit
import Models

public class BaseViewController: UIViewController {
    
    public var viewHasAppeared: Bool = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewHasAppeared = true
    }
    
    //MAKR: - ViewModelDelegate
    public func startWaiting() {
        self.view.showWaitingAnimation()
    }
    
    public func stopWaiting() {
        self.view.hideWaitingAnimation()
    }
    
    public func updateUI(with error: Error?) {
        
    }
}
