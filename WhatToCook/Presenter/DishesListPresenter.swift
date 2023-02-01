import UIKit

// MARK: - DishesListPresenter
final class DishesListPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: DishesListController?
    private let mealShortInfoManager = MealShortInfoManager()

    init(viewController: DishesListController? = nil) {
        self.viewController = viewController
        mealShortInfoManager.delegate = self
    }
}

// MARK: - Helpers
extension DishesListPresenter {

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func loadDishes(forCategory category: String) {
        mealShortInfoManager.performRequest(by: category)
    }

    func giveNumberOfDishes() -> Int {
        mealShortInfoManager.meals.count
    }

    func configureCell(forIndexPath indexPath: IndexPath, at tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell") as? DishCell else {
            return UITableViewCell()
        }

        cell.dishDescriptionLabel.text = mealShortInfoManager.meals[indexPath.row].strMeal
        let image = mealShortInfoManager.meals[indexPath.row].strMealThumb
        if let imageURL = URL(string: image) {
            getData(from: imageURL) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    cell.dishImageView.image = UIImage(data: data)
                }
            }
        }
        tableView.separatorInset = UIEdgeInsets.zero
        return cell
    }

    func giveDishID(forIndex index: Int) -> String {
        mealShortInfoManager.meals[index].idMeal
    }
}

// MARK: - MealShortInfoManagerDelegate
extension DishesListPresenter: MealShortInfoManagerDelegate {

    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewController?.dishesListView.tableView.reloadData()
        }
    }
}
