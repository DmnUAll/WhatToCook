import UIKit

// MARK: - RecipeCell
final class RecipeCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let recipeLabel: UILabel = {
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
        addSubview(recipeLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension RecipeCell {

    private func setupConstraints() {
        let constraints = [
            recipeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            recipeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            recipeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            recipeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
