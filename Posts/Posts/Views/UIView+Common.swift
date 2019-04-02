//
//  UIView+Common.swift
//  Posts
//
//  Created by Xinghou Liu on 01/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import UIKit

public enum ViewTags {
    static let spinner: Int = 123867
    static let mask: Int = 894382
}

extension UIView {
    
    //MARK: - Spinner
    
    // show a waiting animation in a view with dark background
    func showWaitingAnimation()
    {
        let maskView = UIView.init(frame: self.bounds)
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        maskView.tag = ViewTags.mask
        maskView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        maskView.accessibilityIdentifier = AccessibilityIDs.spinnerMask
        self.addSubview(maskView)
        
        let spinner = UIActivityIndicatorView.init(style: .whiteLarge)
        spinner.accessibilityIdentifier = AccessibilityIDs.spinner
        spinner.tag = ViewTags.spinner
        spinner.center = maskView.center;
        spinner.startAnimating()
        
        maskView.addSubview(spinner)
        
    }
    
    // remove the waiting animation
    func hideWaitingAnimation()
    {
        if let maskView = self.subviews.first(where: {$0.tag == ViewTags.mask }) {
            maskView.removeFromSuperview()
        }
    }
}
