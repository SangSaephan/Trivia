//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Sang Saephan on 1/29/21.
//  Copyright © 2021 Sang Saephan. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trivia Categories"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.warriorsYellow]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.warriorsYellow]
        navBarAppearance.backgroundColor = UIColor.warriorsBlue
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchCategories { [weak self] (categories) in
            DispatchQueue.main.async {
                self?.viewModel.categories = categories.sorted(by: {$0.name < $1.name})
                self?.tableView.reloadData()
            }
        }
    }

}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = viewModel.categories?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionsVC = storyboard?.instantiateViewController(identifier: "QuestionsViewController") as! QuestionsViewController
        
        questionsVC.categoryID = viewModel.categories?[indexPath.row].id
        
        navigationController?.pushViewController(questionsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
