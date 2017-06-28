//
//  GitHubResponse.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class GitHubResponse: ResponseObjectSerializable {
    var repositoryResponse: GitHubRepositoryResponse?
    var errorResponse: GitHubErrorReponse?
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [AnyHashable: Any] else { return }
        errorResponse = GitHubErrorReponse(response: response, representation: representation)
        repositoryResponse = GitHubRepositoryResponse(response: response, representation: representation)
    }
}
