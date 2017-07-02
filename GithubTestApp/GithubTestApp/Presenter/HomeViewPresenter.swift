//
//  HomeViewPresenter.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

fileprivate enum ThreadCounter {
    case first
    case second
}

class HomeViewPresenter: BasePresenter, HomeViewPresenterProtocol {
    weak var delegate: HomeViewPresenterDelegate?
    
    override var items: SynchronizedArray<GitHubRepository> {
        return dataManager.repositories
    }
    private var page: Int = 0
    private let intemsPerReqeust = 15
    private var isLoading: Bool = false
    private var queryText: String?
    private let dispatchGroup = DispatchGroup()
    private var serialQueue = DispatchQueue(label: "my.serial.queue")

    func didRecieveQueryText(_ query: String?) {
        queryText = query
        items.removeAll()
        loadNextData()
        delegate?.clearResults()
    }
    
    // MARK: Requests
    
    func loadNextData() {
        isLoading = true
        cancelSearch { [weak self] in
            self?.dataManager.clearData(withCompletion: nil)
            self?.serialQueue.async {
                self?.loadData(fromThreadNumber: .first)
                self?.loadData(fromThreadNumber: .second)
                _ = self?.dispatchGroup.wait(timeout: .now() + 25)
                self?.dispatchGroup.notify(queue: .main, execute: {
                    self?.isLoading = false
                    self?.delegate?.allRequestsCompleted()
                })
            }
        }
    }
    
    func cancelSearch(withCompletion completion: (() -> Void)?) {
        apiManager?.cancelAllTasks(withCompletion: completion)
    }
    
    func heightForHeader() -> Float {
        return isLoading ? heightForRow() : 0
    }
    
    private func loadData(fromThreadNumber number: ThreadCounter) {
        let page = number == .first ? 1 : 2
        dispatchGroup.enter()
        
        self.apiManager?.searchRepositories(withPageNumber: page, resultsCount: self.intemsPerReqeust, searchQuery: self.queryText, completion: { [weak self] (response, error) in
            DispatchQueue.main.async { [weak self] in
                if let gitResponse = response?.repositoryResponse {
                    if number == .first {
                        self?.proceedWithResultsFromFirstThread(results: gitResponse)
                    } else {
                        self?.proceedWithResultsFromSecondThread(results: gitResponse)
                    }
                    self?.dataManager.store(items: gitResponse.items)
                } else if let gitError = response?.errorResponse {
                    let commonError = CommonError(withGitHubError: gitError)
                    self?.delegate?.secondRequestDidFinish(withIndexPathsToInsert: nil, error: commonError)
                } else {
                    self?.delegate?.secondRequestDidFinish(withIndexPathsToInsert: nil, error: error)
                }
                self?.dispatchGroup.leave()
            }
        })
    }
    
    private func proceedWithResultsFromFirstThread(results: GitHubRepositoryResponse) {
        if items.count > 0 {
            let currentItems = items.all
            items.removeAll()
            items.append(collection: results.items)
            items.append(collection: currentItems)
        } else {
            items.append(collection: results.items)
        }
        var indexPaths = [IndexPath]()
        for index in 0..<results.items.count {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        self.delegate?.firstRequestDidFinish(withIndexPathsToInsert: indexPaths, error: nil)
    }
    
    private func proceedWithResultsFromSecondThread(results: GitHubRepositoryResponse) {
        let startIndex = items.count == 0 ? 0 : items.count
        items.append(collection: results.items)
        var indexPaths = [IndexPath]()
        for index in startIndex..<results.items.count + startIndex {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        self.delegate?.secondRequestDidFinish(withIndexPathsToInsert: indexPaths, error: nil)
    }
}
