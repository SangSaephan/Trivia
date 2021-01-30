//
//  File.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

struct Questions: Codable {
    var results: [Question]
}

struct Question: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}
