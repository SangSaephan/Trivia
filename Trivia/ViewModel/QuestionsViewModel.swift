//
//  QuestionsViewModel.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

class QuestionsViewModel {
    var categoryID: Int?
    
    weak var questionsVC: QuestionsViewController?
    
    init(categoryID: Int, viewController: QuestionsViewController) {
        self.categoryID = categoryID
        self.questionsVC = viewController
        
        fetchQuestions(categoryID: categoryID) { [weak self] (questions) in
            DispatchQueue.main.async {
                self?.questionsVC?.updateUI(questions: questions)
            }
        }
    }
    
    private func fetchQuestions(categoryID: Int, _ completion: @escaping ([Question]) -> ()) {
        NetworkManager.shared.fetchQuestionsByCategory(categoryID: categoryID) { (questions) in
            completion(questions)
        }
    }
    
    func setText(word: String) -> String {
        
        let data = Data(word.utf8)
        
        if let attributedString =  try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
            
            return attributedString.string
        }
        
        return ""
    }
    
    func presentAlert(message: String, answerStatus: AlertView.Answer) {
        let alert = AlertViewController(message: message, answerStatus: answerStatus)
        alert.modalPresentationStyle = .overCurrentContext
        alert.addAction = {
            if answerStatus == .correct {
                if let id = self.categoryID {
                    self.fetchQuestions(categoryID: id, { (questions) in
                        DispatchQueue.main.async {
                            self.questionsVC?.updateUI(questions: questions)
                        }
                    })
                }
            }
        }
        
        questionsVC?.present(alert, animated: false, completion: nil)
    }
}
