//
//  NetworkManager.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let categoriesURL = "https://opentdb.com/api_category.php"
    
    static var shared = NetworkManager()
    
    private init() { }
    
    func fetchCategories(_ completion: @escaping ([Category]) -> ()) {
        guard let url = URL(string: categoriesURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let categoriesJSON = try JSONDecoder().decode(Categories.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(categoriesJSON.trivia_categories)
                    }
                } catch {
                    fatalError("Could not parse categories JSON.")
                }
            }
        }.resume()
    }
    
    func fetchQuestionsByCategory(categoryID: Int, _ completion: @escaping ([Question]) -> ()) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(categoryID)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let questionsJSON = try JSONDecoder().decode(Questions.self, from: data)
                    
                    completion(questionsJSON.results)
                } catch {
                    fatalError("Could not parse questions JSON.")
                }
            }
        }.resume()
    }
}
