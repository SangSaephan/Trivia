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
        
        fetchQuestions(categoryID: categoryID) { [weak self] (result) in
            self?.handleFetchResult(result: result)
        }
    }
    
    private func fetchQuestions(categoryID: Int, _ completion: @escaping (Result<[Question], NetworkError>) -> ()) {
        NetworkManager.shared.fetchQuestionsByCategory(categoryID: categoryID) { (result) in
            completion(result)
        }
    }
    
    private func handleFetchResult(result: Result<[Question], NetworkError>) {
        switch result {
             
        case .success(let questions):
            DispatchQueue.main.async {
                self.questionsVC?.updateUI(questions: questions)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
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
        alert.addAction = { [weak self] in
            if answerStatus == .correct {
                if let id = self?.categoryID {
                    self?.fetchQuestions(categoryID: id, { (result) in
                        self?.handleFetchResult(result: result)
                    })
                }
            }
        }
        
        questionsVC?.present(alert, animated: false, completion: nil)
    }
}
