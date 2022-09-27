//
//  MealShortInfoManager.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import Foundation

protocol MealFullInfoManagerDelegate {
    func updateUI()
}

class MealFullInfoManager {
    
    var meals: [[String: String?]] = []
    var delegate: MealFullInfoManagerDelegate?
    
    func performRequest(by linkTail: String) {
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(linkTail)") {
            print(url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                if let safeData = data {
                    self.parseJSON(fullInfoData: safeData)
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(fullInfoData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MealFullInfoData.self, from: fullInfoData)
            meals = decodedData.meals
            delegate?.updateUI()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
