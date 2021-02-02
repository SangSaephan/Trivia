//
//  AlertView.swift
//  Trivia
//
//  Created by Sang Saephan on 2/2/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    enum Answer {
        case correct
        case incorrect
    }
    
    @IBOutlet var contentView: UIView!
    
    var answer: Answer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
