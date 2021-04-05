//
//  NetworkManager.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badJSONParse
}

class NetworkManager {
    
    private let categoriesURL = "https://opentdb.com/api_category.php"
    
    static var shared = NetworkManager()
    
    private init() { }
    
    func fetchCategories(_ completion: @escaping (Result<[Category], NetworkError>) -> ()) {
        guard let url = URL(string: categoriesURL) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let categoriesJSON = try JSONDecoder().decode(Categories.self, from: data)
                    
                    completion(.success(categoriesJSON.trivia_categories))
                } catch {
                    completion(.failure(.badJSONParse))
                }
            }
        }.resume()
    }
    
    func fetchQuestionsByCategory(categoryID: Int, _ completion: @escaping (Result<[Question], NetworkError>) -> ()) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(categoryID)") else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let questionsJSON = try JSONDecoder().decode(Questions.self, from: data)
                    
                    completion(.success(questionsJSON.results))
                } catch {
                    completion(.failure(.badJSONParse))
                }
            }
        }.resume()
    }
}
