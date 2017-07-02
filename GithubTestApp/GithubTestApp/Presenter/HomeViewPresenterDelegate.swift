//
//  HomeViewPresenterDelegate.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

protocol HomeViewPresenterDelegate: class {
    func clearResults()
    func firstRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: CommonError?)
    func secondRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: CommonError?)
    func allRequestsCompleted()
}
