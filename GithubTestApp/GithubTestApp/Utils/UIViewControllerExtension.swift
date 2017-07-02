//
//  UIViewControllerExtension.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 02.07.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

fileprivate struct InternalValues {
    static var associatedObjectKey = "dimViewKey"
    static var animationDuration = 0.25
}

extension UIViewController {
    private(set) weak var dimView: UIView? {
        get {
            return objc_getAssociatedObject(self, &InternalValues.associatedObjectKey) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &InternalValues.associatedObjectKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func showDimView() {
        self.dimView?.removeFromSuperview()
        
        let dimView = UIView(frame: view.frame)
        self.dimView = dimView
        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0
        view.addSubview(dimView)
        view.bringSubview(toFront: dimView)
        UIView.animate(withDuration: InternalValues.animationDuration) {
            dimView.alpha = 0.65
        }
        
    }
    
    func hideDimView() {
        UIView.animate(withDuration: InternalValues.animationDuration, animations: { [weak self] in
            self?.dimView?.alpha = 0
        }) { [weak self] (success) in
            self?.dimView?.removeFromSuperview()
            self?.dimView = nil
        }
    }
}
