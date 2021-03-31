//
//  Categories.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

struct Categories: Codable {
    var trivia_categories: [Category]
}

struct Category: Codable {
    var id: Int
    var name: String
}
