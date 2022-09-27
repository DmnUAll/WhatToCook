//
//  MealsListViewController.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import UIKit

class MealsListViewController: UIViewController {
    
    lazy var mealShortInfoManager = MealShortInfoManager()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealShortInfoManager.delegate = self
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MealInfoViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        destinationVC.mealFullInfoManager.performRequest(by: mealShortInfoManager.meals[index].idMeal)
        destinationVC.navigationItem.title = navigationItem.title! + " meal"
        updateUI()
    }
}

extension MealsListViewController: MealShortInfoManagerDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MealsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mealShortInfoManager.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealTableViewCell
        
        cell.mealDescriptionLabel.text = mealShortInfoManager.meals[indexPath.row].strMeal
        
        // Download an image by URL
        let image = mealShortInfoManager.meals[indexPath.row].strMealThumb
        if let imageURL = URL(string: image) {
            getData(from: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async() {
                    cell.mealImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
}


