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
    
    var viewModel: CategoriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = CategoriesViewModel(viewController: self)
    }
    
    func configureUI() {
        title = "Trivia Categories"
        
        // Source: https://medium.com/better-programming/swift-gradient-in-4-lines-of-code-6f81809da741
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.warriorsBlue?.cgColor ?? UIColor.blue.cgColor, UIColor.warriorsYellow?.cgColor ?? UIColor.yellow.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.warriorsYellow ?? UIColor.yellow]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.warriorsYellow ?? UIColor.yellow]
        navBarAppearance.backgroundColor = UIColor.warriorsBlue
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = viewModel?.categories?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionsVC = storyboard?.instantiateViewController(identifier: "QuestionsViewController") as! QuestionsViewController
        
        questionsVC.categoryID = viewModel?.categories?[indexPath.row].id
        
        navigationController?.pushViewController(questionsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
