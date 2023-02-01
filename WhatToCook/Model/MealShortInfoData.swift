import Foundation

// MARK: - MealShortInfoData
struct MealShortInfoData: Codable {
    let meals: [MealShortInfo]
}

// MARK: - MealShortInfo
struct MealShortInfo: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
