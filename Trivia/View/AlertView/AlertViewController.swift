//
//  AlertViewController.swift
//  Trivia
//
//  Created by Sang Saephan on 2/2/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet private var alertView: AlertView!
    
    private var message: String!
    private var answerStatus: AlertView.Answer!
    
    var addAction: (() -> ())?
    
    init(message: String, answerStatus: AlertView.Answer) {
        super.init(nibName: nil, bundle: nil)
        
        self.message = message
        self.answerStatus = answerStatus
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.imageView.image = answerStatus == .correct ? UIImage(named: "Happy") : UIImage(named: "Pensive")
        
        alertView.messageLabel.text = message
        
        alertView.dismissButton.setTitle(answerStatus == .correct ? "Next Question" : "Try Again", for: .normal)
        alertView.dismissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.transition(with: alertView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.alertView.isHidden = false
        }, completion: nil)
    }
    
    @objc func buttonTapped() {
        addAction?()
        dismiss(animated: true, completion: nil)
    }

}
