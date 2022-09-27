//
//  MealData.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import Foundation

struct MealCategoryData: Codable {
    let meals: [MealCategory]
}

struct MealCategory: Codable {
    let strCategory: String
}
