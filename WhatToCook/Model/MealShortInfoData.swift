//
//  MealShortInfoData.swift
//  WhatToCook
//
//  Created by Илья Валито on 20.09.2022.
//

import Foundation

struct MealShortInfoData: Codable {
    let meals: [MealShortInfo]
}

struct MealShortInfo: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
