//
//  ViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 28.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared .sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }


    @IBAction func buttonDidTap(_ sender: Any) {
        apiManager.searchRepositories(withPageNumber: 0, resultsCount: 5) { (reponse, error) in
            print(reponse as Any)
        }
        
        apiManager.searchRepositoriesError(withPageNumber: 0, resultsCount: 5) { (reponse, error) in
            print(reponse as Any)
        }

//        apiManager.searchRepositories(withPageNumber: 0, resultsCount: 0)
    }
}

