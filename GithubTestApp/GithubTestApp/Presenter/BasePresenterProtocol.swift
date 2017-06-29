//
//  BasePresenterProtocol.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol {
    var apiManager: APIManager? { get set }
    var dataManager: DataManager! { get set }
    var items: SynchronizedArray<GitHubRepository> { get }
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func dataForCell(atIndexPath indexPath: IndexPath) -> GitHubRepository?
    func heightForRow() -> Float
    func didSelectCell(atIndexPath indexPath: IndexPath)
}
