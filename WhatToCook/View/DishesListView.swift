import UIKit

// MARK: - DishesListView
final class DishesListView: UIView {

    // MARK: - Properties and Initializers
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.backgroundColor = .wtcYellow
        tableView.separatorColor = .wtcOrange
        tableView.register(DishCell.self, forCellReuseIdentifier: "dishCell")
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
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension DishesListView {

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
