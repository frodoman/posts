//
//  ViewController.swift
//  Posts
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import UIKit
import Models

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let client = NetworkService()
        client.getAllInfo { (posts, users, comments, error) in
            if let error = error {
                print("** ERROR: \n", error)
            }
            else {
                print("** POSTS: \n", posts.count)
                print("** USERS: \n", users.count)
                print("** COMMENTS: \n", comments.count)
            }
        }
    }
}

