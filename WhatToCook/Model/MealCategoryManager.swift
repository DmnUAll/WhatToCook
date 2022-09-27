//
//  MealManager.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//
import Foundation

protocol MealCategoryManagerDelegate {
    func updateUI()
}

class MealCategoryManager {
    
    var mealCategories: [MealCategory] = []
    var delegate: MealCategoryManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                if let safeData = data {
                    self.parseJSON(categoryData: safeData)
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(categoryData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MealCategoryData.self, from: categoryData)
            mealCategories = decodedData.meals
            delegate?.updateUI()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
