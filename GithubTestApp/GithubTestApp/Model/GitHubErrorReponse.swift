//
//  GitHubErrorReponse.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class GitHubErrorReponse: ResponseObjectSerializable {
    var message: String?
    var errors = [GitHubError]()
    var documentationURL: String?
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [AnyHashable: Any],
            let message = representation["message"] as? String,
            let documentationURL = representation["documentation_url"] as? String,
            let errors = representation["errors"] as? [[AnyHashable: Any]] else { return nil }
    
        self.message = message
        self.documentationURL = documentationURL
        for errorRaw in errors {
            if let errorModel = GitHubError(response: response, representation: errorRaw) {
                self.errors.append(errorModel)
            }
        }
    }
}
