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
}
