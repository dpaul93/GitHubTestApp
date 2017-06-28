//
//  GitHubRepository.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 28.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class GitHubRepository: ResponseObjectSerializable {
    var x: String?
    var y: String?
    var stargazersCount: Int = 0
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [AnyHashable: Any] else { return }
        stargazersCount = representation["stargazers_count"] as? Int ?? 0
    }
}
