import UIKit

// MARK: - DishInfoView
final class DishInfoView: UIView {

    // MARK: - Properties and Initializers
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
        tableView.register(NameCell.self, forCellReuseIdentifier: "nameCell")
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: "ingredientsCell")
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "recipeCell")
        tableView.backgroundColor = .wtcYellow
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var linkTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "This app was made, using www.themealdb.com API")
        attributedString.addAttribute(.link, value: "https://www.themealdb.com",
                                      range: NSRange(location: 25, length: 17))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .wtcYellow
        textView.attributedText = attributedString
        textView.textAlignment = .center
        textView.font = UIFont(name: "Menlo Bold", size: 12)
        textView.textColor = .wtcGreen
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .wtcOrange
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension DishInfoView {

    private func addSubviews() {
        addSubview(tableView)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor),
            linkTextView.heightAnchor.constraint(equalToConstant: 24),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
