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

extension UIViewController {
    public func showError(with error: Error,
                          retry: @escaping ()-> Void ) {
        let alert = UIAlertController(title: Texts.ViewTitles.error,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: Texts.ButtonTitles.ok,
                                     style: .default) { (action) in
                                        alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        let retryAction = UIAlertAction(title: Texts.ButtonTitles.retry,
                                        style: .cancel) { (action) in
                                            retry()
                                            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(retryAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
