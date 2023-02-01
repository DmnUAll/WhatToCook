import UIKit

// MARK: - DishesListController
final class DishesListController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: DishesListPresenter?

    let dishesListView = DishesListView()

    convenience init(forCategory category: String) {
        self.init()
        presenter = DishesListPresenter(viewController: self)
        dishesListView.tableView.dataSource = self
        dishesListView.tableView.delegate = self
        presenter?.loadDishes(forCategory: category)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dishes"
        navigationItem.backButtonTitle = "Dishes"
        view.backgroundColor = .wtcOrange
        view.addSubview(dishesListView)
        setupConstraints()
    }
}

// MARK: - Helpers
extension DishesListController {

    private func setupConstraints() {
        let constraints = [
            dishesListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dishesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishesListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dishesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UITableViewDataSource
extension DishesListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfDishes = presenter?.giveNumberOfDishes() else { return 0 }
        return numberOfDishes
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presenter?.configureCell(forIndexPath: indexPath, at: tableView) else {
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DishesListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let dishID = presenter?.giveDishID(forIndex: indexPath.row) else { return }
        navigationController?.pushViewController(DishInfoController(forDishID: dishID), animated: true)
    }
}
