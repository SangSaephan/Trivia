//
//  CategoriesViewModel.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    var categories: [Category]?
    
    func fetchCategories(_ completion: @escaping ([Category]) -> ()) {
        NetworkManager.shared.fetchCategories { (categories) in
            completion(categories)
        }
    }
}
