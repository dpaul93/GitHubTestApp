//
//  GitHubRepositoryResponse.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 28.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class GitHubRepositoryResponse: ResponseObjectSerializable {
    var totalCount: Int?
    var incompleteResuls: Bool?
    var items = [GitHubRepository]()
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [AnyHashable: Any],
            let totalCount = representation["total_count"] as? Int,
            let incompleteResuls = representation["incomplete_results"] as? Bool,
            let itemsArray = representation["items"] as? [[AnyHashable: Any]] else { return nil }
        
        self.totalCount = totalCount
        self.incompleteResuls = incompleteResuls
        for repositoryRaw in itemsArray {
            if let repositoryModel = GitHubRepository(response: response, representation: repositoryRaw) {
                items.append(repositoryModel)
            }
        }
    }
}
