//
//  HomeViewPresenterProtocol.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

protocol HomeViewPresenterProtocol: BasePresenterProtocol {
    weak var delegate: HomeViewPresenterDelegate? { get set }

    func didRecieveQueryText(_ query: String?)
    
    func heightForHeader() -> Float

    func loadNextData()
    func cancelSearch(withCompletion completion: (() -> Void)?)
}
