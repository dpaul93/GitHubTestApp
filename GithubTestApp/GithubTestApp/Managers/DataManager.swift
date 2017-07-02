//
//  DataManager.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation
import RealmSwift

typealias DataManagerCompletion = (Bool) -> Void
class DataManager {
    var repositories = SynchronizedArray<GitHubRepository>()
    var storedRepositories = SynchronizedArray<GitHubRepository>()
    let realmQueue = DispatchQueue(label: "com.example.realmQueue")
    
    init() {
        loadData()
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let result = realm.objects(GitHubRepository.self)
            for repo in result {
                storedRepositories.append(element: repo)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func store(items: [GitHubRepository]) {
        storedRepositories.append(collection: items)
        realmQueue.async {
            let realm = try! Realm()
            realm.beginWrite()
            for repo in items {
                let value: [AnyHashable: Any] = [
                    "fullName" : repo.fullName,
                    "repositoryDescription" : repo.repositoryDescription,
                    "repositoryURL" : repo.repositoryURL,
                    "stargazersCount" : repo.stargazersCount
                ]
                realm.create(GitHubRepository.self, value: value, update: false)
            }
            try? realm.commitWrite()
        }
    }
    
    func clearData(withCompletion completion: DataManagerCompletion?) {
        storedRepositories.removeAll()
        realmQueue.async { [weak self] in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.deleteAll()
                }
                self?.perfomOnMainThread(completion: completion, success: true)
            } catch {
                self?.perfomOnMainThread(completion: completion, success: false)
            }
        }
    }
    
    private func perfomOnMainThread(completion: DataManagerCompletion?, success: Bool) {
        DispatchQueue.main.async {
            completion?(success)
        }
    }
}
