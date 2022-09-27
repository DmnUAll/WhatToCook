//
//  MainViewController.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import UIKit
import Network

class MainViewController: UIViewController {
    
    private var mealCategoryManager = MealCategoryManager()
    private var selectedCategory: String {
        return mealCategoryManager.mealCategories[pickerView.selectedRow(inComponent: 0)].strCategory
    }
    
    @IBOutlet private weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        mealCategoryManager.delegate = self
        mealCategoryManager.performRequest()
        
        pickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkInternetConnection()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MealsListViewController
        if segue.identifier == "showMeals" {
            destinationVC.mealShortInfoManager.performRequest(by: selectedCategory)
            destinationVC.navigationItem.title = selectedCategory
        } else {
            destinationVC.mealShortInfoManager.loadFavorites()
            destinationVC.navigationItem.title = "Favorites"
        }
        updateUI()
    }
    
    func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                return
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "No Internet connection", message: "Please check your Internet connection and restart the App.")
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension MainViewController: MealCategoryManagerDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealCategoryManager.mealCategories.count
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealCategoryManager.mealCategories[row].strCategory
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string:  mealCategoryManager.mealCategories[row].strCategory, attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "redColor") ?? .red])
    }
}

