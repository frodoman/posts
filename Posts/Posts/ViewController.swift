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
        
        let client = DataManager()
        client.getAllData { (posts, users, comments, error) in
            if let error = error {
                print("** ERROR: ", error)
            }
            else {
                print("** POSTS: ", posts.count)
                print("** USERS: ", users.count)
                print("** COMMENTS: ", comments.count)
            }
        }
    }
}

