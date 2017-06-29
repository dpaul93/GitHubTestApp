//
//  GitHubRepository.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 28.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class GitHubRepository: Object, ResponseObjectSerializable {
    dynamic var fullName: String = ""
    dynamic var repositoryDescription: String = ""
    dynamic var repositoryURL: String = ""
    dynamic var stargazersCount: Int = 0
    
    required init?(response: HTTPURLResponse, representation: Any) {
        super.init()
        guard let representation = representation as? [AnyHashable: Any] else { return }
        stargazersCount = representation["stargazers_count"] as? Int ?? 0
        fullName = (representation["full_name"] as? String)?.getTrimmedString(byNumberOfCharacters: 30) ?? ""
        repositoryURL = representation["html_url"] as? String ?? ""
        repositoryDescription = (representation["description"] as? String)?.getTrimmedString(byNumberOfCharacters: 30) ?? ""
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
//        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
//        fatalError("init(value:schema:) has not been implemented")
    }
}
