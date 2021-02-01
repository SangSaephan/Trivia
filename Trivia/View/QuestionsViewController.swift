//
//  QuestionsViewController.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet var questionsLabel: UILabel!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    
    var categoryID: Int?
    var viewModel: QuestionsViewModel?
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        if let id = categoryID {
            viewModel = QuestionsViewModel(categoryID: id, viewController: self)
            viewModel?.fetchQuestions(categoryID: id, { (questions) in
                DispatchQueue.main.async {
                    self.updateUI(questions: questions)
                }
            })
        }
    }
    
    func configureUI() {
        questionsLabel.text = ""
        
        [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
            $0!.setTitle("", for: .normal)
            $0!.layer.cornerRadius = $0!.bounds.size.height / 2
            $0!.titleLabel?.numberOfLines = 0
            $0!.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0!.isHidden = true
        }
    }
    
    func updateUI(questions: [Question]) {
        guard questions.count - 1 > 0 else { return }
        
        let random = Int.random(in: 0...questions.count - 1)
        questionsLabel.text = viewModel?.setText(word: questions[random].question)
        
        print(questions[random].question)
        
        var answers = [questions[random].correct_answer,
                       questions[random].incorrect_answers[0]
        ]
        
        if questions[random].type == "boolean" {
            [answerButton1, answerButton4].forEach {
                $0!.isHidden = true
            }
            
            [answerButton2, answerButton3].forEach {
                $0!.isHidden = false
            }
            
            answers.shuffle()
            
            answerButton2.setTitle(viewModel?.setText(word: answers[0]), for: .normal)
            answerButton3.setTitle(viewModel?.setText(word: answers[1]), for: .normal)
        } else {
            [answerButton1, answerButton2, answerButton3, answerButton4].forEach {
                $0!.isHidden = false
            }
            
            print(questions[random].correct_answer)
            
            answers += [questions[random].incorrect_answers[1], questions[random].incorrect_answers[2]]
            answers.shuffle()
            
            print(answers)
            
            answerButton1.setTitle(viewModel?.setText(word: answers[0]), for: .normal)
            answerButton2.setTitle(viewModel?.setText(word: answers[1]), for: .normal)
            answerButton3.setTitle(viewModel?.setText(word: answers[2]), for: .normal)
            answerButton4.setTitle(viewModel?.setText(word: answers[3]), for: .normal)
        }
        
        for i in 0 ..< answers.count {
            if answers[i] == questions[random].correct_answer {
                correctAnswer = i + 1
                
                if questions[random].type == "boolean" {
                    correctAnswer += 1
                }
            }
        }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        var title = ""
        var message = ""
        
        if correctAnswer == sender.tag {
            title = "CORRECT!"
            message = "That's the right answer!"
        } else {
            title = "INCORRECT!"
            message = "Sorry, that is not the right answer."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
            if title == "CORRECT!" {
                if let id = self.categoryID {
                    self.viewModel?.fetchQuestions(categoryID: id, { (questions) in
                        DispatchQueue.main.async {
                            self.updateUI(questions: questions)
                        }
                    })
                }
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    

}
