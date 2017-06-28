//
//  GitHubError.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class GitHubError: ResponseObjectSerializable {
    var resource: String?
    var field: String?
    var code: String?
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [AnyHashable: Any] else { return }
        resource = representation["resource"] as? String
        field = representation["field"] as? String
        code = representation["code"] as? String
    }
}
