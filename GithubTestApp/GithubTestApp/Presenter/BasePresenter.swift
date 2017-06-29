//
//  BasePresenter.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class BasePresenter: BasePresenterProtocol {
    var apiManager: APIManager?
    var dataManager: DataManager!
    var items: SynchronizedArray<GitHubRepository> {
        return SynchronizedArray<GitHubRepository>()
    }
    
    // MARK: TableView Helpers
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return items.count
    }
    
    func dataForCell(atIndexPath indexPath: IndexPath) -> GitHubRepository? {
        return items[indexPath.row]
    }
    
    func heightForRow() -> Float {
        return 80
    }
    
    func didSelectCell(atIndexPath indexPath: IndexPath) { }
}
