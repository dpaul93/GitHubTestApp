//
//  CommonError.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 02.07.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class CommonError {
    var title: String = "Error"
    var message: String?
    var code: Int = 0
    
    init(withError error: Error?) {
        message = error?.localizedDescription
    }
    
    init(withGitHubError error: GitHubErrorReponse?) {
        message = error?.message
    }
}
