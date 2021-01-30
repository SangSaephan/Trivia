//
//  QuestionsViewModel.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

class QuestionsViewModel {
    var questions: [Question]?
    
    weak var questionsVC: QuestionsViewController?
    
    init(categoryID: Int, viewController: QuestionsViewController) {
        self.questionsVC = viewController
    }
    
    func fetchQuestions(categoryID: Int, _ completion: @escaping ([Question]) -> ()) {
        NetworkManager.shared.fetchQuestionsByCategory(categoryID: categoryID) { (questions) in
            completion(questions)
        }
    }
}
