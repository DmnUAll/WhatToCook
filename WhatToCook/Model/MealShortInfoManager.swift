import Foundation

// MARK: - MealShortInfoManagerDelegate protocol
protocol MealShortInfoManagerDelegate: AnyObject {
    func updateUI()
}

// MARK: - MealShortInfoManager
class MealShortInfoManager {

    var meals: [MealShortInfo] = []
    var delegate: MealShortInfoManagerDelegate?

    func performRequest(by linkTail: String) {
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(linkTail)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                if let safeData = data {
                    self.parseJSON(shortInfoData: safeData)
                }
            }
            task.resume()
        }
    }

    private func parseJSON(shortInfoData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MealShortInfoData.self, from: shortInfoData)
            meals = decodedData.meals
            delegate?.updateUI()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func loadFavorites() {
        print("loading favorites")
    }
}
