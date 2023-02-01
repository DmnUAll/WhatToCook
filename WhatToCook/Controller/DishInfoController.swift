import UIKit

// MARK: - DishInfoController
final class DishInfoController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: DishInfoPresenter?
    lazy var dishInfoView = DishInfoView()

    convenience init(forDishID dishID: String) {
        self.init()
        dishInfoView.tableView.dataSource = self
        dishInfoView.tableView.delegate = self
        presenter = DishInfoPresenter(viewController: self)
        presenter?.loadDish(withDishID: dishID)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dish Info"
        view.backgroundColor = .wtcOrange
        view.addSubview(dishInfoView)
        setupConstraints()
    }
}

// MARK: - Helpers
extension DishInfoController {

    private func setupConstraints() {
        let constraints = [
            dishInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dishInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dishInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UITAbleViewDataSource
extension DishInfoController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = presenter?.giveNumberOfSections() else { return 0 }
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = presenter?.giveNumberOfRows(inSection: section) else { return 0 }
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let header = presenter?.giveHeader(forSsection: section) else { return nil }
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presenter?.configureCell(forIndexPath: indexPath, at: tableView) else {
            return UITableViewCell()
        }
        return cell
    }
}

extension DishInfoController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 36
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 6, y: 6, width: 320, height: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.layer.opacity = 0.8
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.backgroundColor = .wtcOrange
        headerView.addSubview(label)
        return headerView
    }
}
