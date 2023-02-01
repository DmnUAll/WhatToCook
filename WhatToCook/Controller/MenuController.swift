import UIKit

// MARK: - MenuController
final class MenuController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: MenuPresenter?

    let menuView = MenuView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WhatToCook"
        navigationItem.backButtonTitle = "Categories"
        view.backgroundColor = .wtcOrange
        view.addSubview(menuView)
        setupConstraints()
        presenter = MenuPresenter(viewController: self)
        menuView.delegate = self
        menuView.dishPicker.delegate = self
        updateUI()
    }
}

// MARK: - Helpers
extension MenuController {

    private func setupConstraints() {
        let constraints = [
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func updateUI() {
        if menuView.activityIndicator.isAnimating {
            menuView.activityIndicator.stopAnimating()
        } else {
            menuView.activityIndicator.startAnimating()
        }
        menuView.infoLabel.isHidden.toggle()
        menuView.dishPicker.isHidden.toggle()
        menuView.goButton.isHidden.toggle()
    }
}

// MARK: - MenuViewDelegate
extension MenuController: MenuViewDelegate {

    func proceedToDishesList() {
        guard let category = presenter?.giveSelectedCategoryName(
            forIndex: menuView.dishPicker.selectedRow(inComponent: 0)) else { return }
        navigationController?.pushViewController(DishesListController(forCategory: category), animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension MenuController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.giveNumberOfDishCategories() ?? 0
    }
}

// MARK: - UIPickerViewDelegate
extension MenuController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.giveDishCategoryName(forRow: row)
    }

    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int
    ) -> NSAttributedString? {
        return NSAttributedString(
            string: presenter?.giveDishCategoryName(forRow: row) ?? "None",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "redColor") ?? .red])
    }
}
