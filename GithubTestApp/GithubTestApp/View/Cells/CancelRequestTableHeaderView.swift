//
//  CancelRequestTableHeaderView.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 02.07.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

protocol CancelRequestTableHeaderViewDelegate: class {
    func cancelRequestHeaderView(_ header: CancelRequestTableHeaderView, didPressCancelButton button: Any)
}

class CancelRequestTableHeaderView: UITableViewCell {
    weak var delegate: CancelRequestTableHeaderViewDelegate?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func didPressCancelButton(_ sender: Any) {
        delegate?.cancelRequestHeaderView(self, didPressCancelButton: sender)
    }
}
