//
//  HomeViewPresenterDelegate.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

protocol HomeViewPresenterDelegate {
    func clearResults()
    func firstRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: Error?)
    func secondRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: Error?)
}
