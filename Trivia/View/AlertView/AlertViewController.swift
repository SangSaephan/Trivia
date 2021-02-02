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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.dismissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.transition(with: alertView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.alertView.isHidden = false
        }, completion: nil)
    }
    
    @objc func buttonTapped() {
        dismiss(animated: false, completion: nil)
    }

}
