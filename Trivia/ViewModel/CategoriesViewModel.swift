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
    
    weak var categoriesVC: CategoriesViewControllerDelegate?
    
    init(viewController: CategoriesViewControllerDelegate) {
        self.categoriesVC = viewController
        
        fetchCategories { [weak self] (result) in
            switch result {
                
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.categories = categories.sorted(by: {$0.name < $1.name})
                    self?.categoriesVC?.updateTableView()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCategories(_ completion: @escaping (Result<[Category], NetworkError>) -> ()) {
        NetworkManager.shared.fetchCategories { (result) in
            completion(result)
        }
    }
}
