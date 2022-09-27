//
//  MealInfoViewController.swift
//  WhatToCook
//
//  Created by Илья Валито on 26.09.2022.
//

import UIKit

class MealInfoViewController: UITableViewController {
    
    lazy var mealFullInfoManager = MealFullInfoManager()
    
    @IBOutlet private weak var videoBarButton: UIBarButtonItem!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mealNameLabel: UILabel!
    @IBOutlet private weak var cuisineAreaLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var recipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealFullInfoManager.delegate = self
        
        imageView.layer.cornerRadius = imageView.frame.height / 20
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor(named: "redColor")?.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let meal = mealFullInfoManager.meals.first else { return }
                
        // Download an image by URL
        let image = meal["strMealThumb"] ?? "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
        if let imageURL = URL(string: image!) {
            getData(from: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async() {
                    self.videoBarButton.isEnabled = meal["strYoutube"] != "" && meal["strYoutube"] != nil
                    self.imageView.image = UIImage(data: data)
                    self.mealNameLabel.text = meal["strMeal"] ?? "No Name"
                    self.cuisineAreaLabel.text =  meal["strArea"] ?? "No Area"
                    
                    var ingredients = [(String, String)]()
                    var measurements = [(String, String)]()
                    for (key, value) in meal {
                        if key.contains("strIngredient") {
                            if let value = value, value != "" {
                                ingredients.append((key, value))
                            }
                        }
                        if key.contains("strMeasure") {
                            if let value = value, value != "" {
                                measurements.append((key, value))
                            }
                        }
                    }
                    ingredients = ingredients.sorted(by: { $0.0.compare($1.0, options: .numeric) == .orderedAscending })
                    measurements = measurements.sorted(by: { $0.0.compare($1.0, options: .numeric) == .orderedAscending })
                    var resultString = ""
                    for i in 0...ingredients.count - 1 {
                        resultString += "\(ingredients[i].1) - \(measurements[i].1)\n"
                    }
                    self.ingredientsLabel.text = String(resultString.dropLast())
                    self.recipeLabel.text = meal["strInstructions"] ?? "No Recipe"
                    self.updateUI()
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    @IBAction func videoButtonTapped(_ sender: UIBarButtonItem) {
        guard let meal = mealFullInfoManager.meals.first else { return }
        guard let link = meal["strYoutube"] else { return }
        guard let url = URL(string: link!) else {
          return
        }
        UIApplication.shared.open(url)
        
    }
}

extension MealInfoViewController: MealFullInfoManagerDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
