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
    
    //MARK: - Autolayout
    public func pinToSuperviewEdges() {
        pinToSuperviewEdges(left: 0, top: 0, right: 0, bottom: 0)
    }
    
    public func pinToSuperviewEdges(left leftConst: CGFloat,
                                    top topConst: CGFloat,
                                    right rightConst: CGFloat,
                                    bottom bottomConst: CGFloat) {
        guard let superView = self.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: leftConst),
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: topConst),
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant:rightConst),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant:bottomConst)
            ])
    }
    
    public func pinToSuperviewSafeEdges() {
        pinToSuperviewSafeEdges(left: 0, top: 0, right: 0, bottom: 0)
    }
    
    public func pinToSuperviewSafeEdges(left leftConst: CGFloat,
                                        top topConst: CGFloat,
                                        right rightConst: CGFloat,
                                        bottom bottomConst: CGFloat) {
        guard let superView = self.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: leftConst),
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: topConst),
            self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant:rightConst),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant:bottomConst)
            ])
    }
}
