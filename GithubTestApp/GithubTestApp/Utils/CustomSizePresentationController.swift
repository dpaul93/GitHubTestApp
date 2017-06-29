//
//  CustomSizePresentationController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class CustomSizePresentationController: UIPresentationController {
    var frame: CGRect = CGRect.zero
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: Int(frame.size.width * 0.75), height: Int(frame.size.height * 0.75))
        let origin = CGPoint(x: frame.midX - size.width / 2, y: frame.midY - size.height / 2)
        return CGRect(origin: origin, size: size)
    }
}
