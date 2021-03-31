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
    
    weak var categoriesVC: CategoriesViewController?
    
    init(viewController: CategoriesViewController) {
        self.categoriesVC = viewController
        
        fetchCategories { [weak self] (categories) in
            DispatchQueue.main.async {
                self?.categories = categories.sorted(by: {$0.name < $1.name})
                self?.categoriesVC?.tableView.reloadData()
            }
        }
    }
    
    private func fetchCategories(_ completion: @escaping ([Category]) -> ()) {
        NetworkManager.shared.fetchCategories { (categories) in
            completion(categories)
        }
    }
}
