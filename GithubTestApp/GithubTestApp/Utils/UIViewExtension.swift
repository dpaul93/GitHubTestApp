//
//  UIViewExtension.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

extension UIView {
    func addDimView(withTransparency transparency: CGFloat) -> UIView {
        let dimView = UIView(frame: bounds)
        dimView.backgroundColor = UIColor(white: 0.0, alpha: transparency)
        addSubview(dimView)
        return dimView
    }
}
