//
//  RepositoryWebViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class RepositoryWebViewController: UIViewController {
    var linkToOpen: String?
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let linkToOpen = linkToOpen, let url = URL(string: linkToOpen) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25)
            webView.loadRequest(request)
        }
    }
    
    // MARK: Actions
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        webView.stopLoading()
        webView.delegate = nil
        webView.removeFromSuperview()
        webView = nil
        dismiss(animated: true, completion: nil)
    }
}
