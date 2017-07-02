//
//  RepositoryWebViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit
import WebKit

class RepositoryWebViewController: UIViewController {
    var linkToOpen: String?
    var dismissalCompletion: (() -> Void)?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
   private weak var wkWebView: WKWebView!
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: CGRect.zero)
        wkWebView = webView
        view.addSubview(webView)
        view.sendSubview(toBack: webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0).isActive = true

        if let linkToOpen = linkToOpen, let url = URL(string: linkToOpen) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 25)
            webView.load(request)
        }
    }
    
    // MARK: Actions
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        wkWebView.uiDelegate = nil
        wkWebView.navigationDelegate = nil
        wkWebView.stopLoading()
        
        dismissalCompletion?()
        
        dismiss(animated: true, completion: nil)
    }
}
