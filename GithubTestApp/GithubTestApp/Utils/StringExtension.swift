//
//  StringExtension.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

extension String {
    func getTrimmedString(byNumberOfCharacters number: Int) -> String {
        if characters.count > number {
            return String(characters.prefix(number))
        } else {
            return self
        }
    }
}
