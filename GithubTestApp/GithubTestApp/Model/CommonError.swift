//
//  CommonError.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 02.07.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

enum ErrorCode: Int {
    case undefined = -1
    case cancelled = 0
}

class CommonError {
    var title: String = "Error"
    var message: String?
    var code: ErrorCode = .undefined
    
    init(withError error: Error?) {
        if let nsError = error as NSError? {
            code = ErrorCode(rawValue: nsError.code) ?? .undefined
        }
        message = error?.localizedDescription
    }
    
    init(withGitHubError error: GitHubErrorReponse?) {
        message = error?.message
    }
}
