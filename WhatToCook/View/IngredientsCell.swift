import UIKit

// MARK: - IngredientsCell
final class IngredientsCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.numberOfLines = 0
        label.textColor = .wtcRed
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .wtcYellow
        addSubview(ingredientsLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IngredientsCell
extension IngredientsCell {

    private func setupConstraints() {
        let constraints = [
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
