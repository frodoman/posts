//
//  ViewController.swift
//  Posts
//
//  Created by Xinghou Liu on 24/03/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import UIKit
import Models

class ViewController: BaseViewController {
    
    private lazy var viewModel: PostsViewModel = {
        let viewModel = PostsViewModel(delegate: self)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!self.viewHasAppeared) {
            self.viewModel.requestData()
        }
        super.viewDidAppear(animated)
    }
}

extension ViewController: ViewModelDelegate {
    
    func startWaiting() {
        
    }
    
    func stopWaiting() {
        
    }
    
    func updateUI(with error: Error?) {
        print("POST: ", self.viewModel.posts.count)
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostsViewModel.cellId)
        {
            return cell
        }
        else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: PostsViewModel.cellId)
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
