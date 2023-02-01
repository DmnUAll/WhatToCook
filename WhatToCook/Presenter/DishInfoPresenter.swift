import UIKit

// MARK: - DishInfoPresenter
final class DishInfoPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: DishInfoController?
    private let mealFullInfoManager = MealFullInfoManager()
    private let sections = [nil, "Ingredients", "Recipe"]

    init(viewController: DishInfoController? = nil) {
        self.viewController = viewController
        mealFullInfoManager.delegate = self
        addPlayButton()
    }
}

// MARK: - Helpers
extension DishInfoPresenter {

    private func addPlayButton() {
        let playButton = UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                                         primaryAction: UIAction(handler: { [weak self] _ in
            guard let self,
                  let meal = self.mealFullInfoManager.meals.first,
                  let link = meal["strYoutube"],
                  let url = URL(string: link!) else { return }
            UIApplication.shared.open(url)
        }))
        viewController?.navigationItem.rightBarButtonItem = playButton
        viewController?.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func loadDish(withDishID dishID: String) {
        mealFullInfoManager.performRequest(by: dishID)
    }

    func giveNumberOfSections() -> Int {
        sections.count
    }

    func giveNumberOfRows(inSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }

    func giveHeader(forSsection section: Int) -> String? {
        sections[section]
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func configureCell(forIndexPath indexPath: IndexPath, at tableView: UITableView) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let castedCell = tableView.dequeueReusableCell(withIdentifier: "imageCell",
                                                                     for: indexPath) as? ImageCell else {
                    return cell
                }
                cell = castedCell
            } else {
                guard let castedCell = tableView.dequeueReusableCell(withIdentifier: "nameCell",
                                                                     for: indexPath) as? NameCell else {
                    return cell
                }
                cell = castedCell
            }
        case 1:
            guard let castedCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell",
                                                                 for: indexPath) as? IngredientsCell else {
                return cell
            }
            cell = castedCell
        case 2:
            guard let castedCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell",
                                                                 for: indexPath) as? RecipeCell else { return cell }
            cell = castedCell
        default:
            return cell
        }
        return cell
    }
}

// MARK: - MealFullInfoManagerDelegate
extension DishInfoPresenter: MealFullInfoManagerDelegate {

    func updateUI() {
        let defaultLink = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
        DispatchQueue.main.async { [weak self] in
            guard let self,
                  let cells = self.viewController?.dishInfoView.tableView.visibleCells,
                  let meal = self.mealFullInfoManager.meals.first else { return }
            let image = meal["strMealThumb"] ?? defaultLink
            if let imageURL = URL(string: image!) {
                self.getData(from: imageURL) { data, _, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        (cells[0] as? ImageCell)?.dishImageView.image = UIImage(data: data)
                    }
                }
            }
            (cells[1] as? NameCell)?.dishNameLabel.text = meal["strMeal"] ?? "No Name"
            (cells[1] as? NameCell)?.dishAreaLabel.text = meal["strArea"] ?? "No Area"
            var ingredients = [(String, String)]()
            var measurements = [(String, String)]()
            for (key, value) in meal {
                if key.contains("strIngredient") {
                    if let value = value, value != "" {
                        ingredients.append((key, value))
                    }
                }
                if key.contains("strMeasure") {
                    if let value = value, value != "" {
                        measurements.append((key, value))
                    }
                }
            }
            ingredients = ingredients.sorted(by: { $0.0.compare($1.0, options: .numeric) == .orderedAscending })
            measurements = measurements.sorted(by: { $0.0.compare($1.0, options: .numeric) == .orderedAscending })
            var resultString = ""
            for index in 0...ingredients.count - 1 {
                resultString += "\(ingredients[index].1) - \(measurements[index].1)\n"
            }
            (cells[2] as? IngredientsCell)?.ingredientsLabel.text = String(resultString.dropLast())
            (cells[3] as? RecipeCell)?.recipeLabel.text = meal["strInstructions"] ?? "No Recipe"
            self.viewController?.dishInfoView.tableView.reloadData()
            let videoButton = self.viewController?.navigationItem.rightBarButtonItem
            videoButton?.isEnabled = meal["strYoutube"] != "" && meal["strYoutube"] != nil
        }
    }
}
