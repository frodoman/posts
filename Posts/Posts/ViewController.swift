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
        client.getPosts() { (result) in
            switch result {
            case .succeed( let posts ):
                print("Posts: ", posts)
            case .failed(let error):
                print("Error: \(error)")
            }
        }
    }
}

