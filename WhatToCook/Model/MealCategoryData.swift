import Foundation

// MARK: - MealCategoryData
struct MealCategoryData: Codable {
    let meals: [MealCategory]
}

// MARK: - MealCategory
struct MealCategory: Codable {
    let strCategory: String
}
