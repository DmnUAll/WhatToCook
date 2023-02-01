import Foundation

// MARK: - MenuPresenter
final class MenuPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: MenuController?
    private let mealCategoryManager = MealCategoryManager()

    init(viewController: MenuController? = nil) {
        self.viewController = viewController
        mealCategoryManager.delegate = self
        mealCategoryManager.performRequest()
    }
}

// MARK: - Helpers
extension MenuPresenter {

    func giveNumberOfDishCategories() -> Int {
        mealCategoryManager.mealCategories.count
    }

    func giveDishCategoryName(forRow row: Int) -> String {
        mealCategoryManager.mealCategories[row].strCategory
    }

    func giveSelectedCategoryName(forIndex index: Int) -> String {
        mealCategoryManager.mealCategories[index].strCategory
    }
}

// MARK: - MealCategoryManagerDelegate
extension MenuPresenter: MealCategoryManagerDelegate {

    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewController?.menuView.dishPicker.reloadAllComponents()
            self.viewController?.menuView.dishPicker.selectRow(11, inComponent: 0, animated: false)
            self.viewController?.updateUI()
        }
    }
}
