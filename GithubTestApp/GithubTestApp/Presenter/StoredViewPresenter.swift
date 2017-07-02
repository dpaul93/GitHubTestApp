//
//  StoredViewPresenter.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class StoredViewPresenter: BasePresenter, StoredViewPresenterProtocol {
    weak var delegate: StoredViewPresenterDelegate?
    override var items: SynchronizedArray<GitHubRepository> {
        return dataManager.storedRepositories
    }
    
    func reloadData() {
        dataManager.loadData()
        delegate?.didReloadData()
    }
    
    func removeAllData() {
        dataManager.clearData(withCompletion: nil)
        delegate?.didReloadData()
    }
}
