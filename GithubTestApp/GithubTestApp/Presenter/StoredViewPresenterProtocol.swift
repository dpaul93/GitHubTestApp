//
//  StoredViewPresenterProtocol.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

protocol StoredViewPresenterProtocol: BasePresenterProtocol {
    var delegate: StoredViewPresenterDelegate? { get set }

    func reloadData()
    func removeAllData()
}
