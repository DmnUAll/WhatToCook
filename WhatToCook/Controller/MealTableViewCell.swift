//
//  MealTableViewCell.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        mealImageView.layer.borderWidth = 1
        mealImageView.layer.borderColor = UIColor(named: "redColor")?.cgColor
    }
}
