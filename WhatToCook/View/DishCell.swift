import UIKit

// MARK: - DishCell
final class DishCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.wtcRed.cgColor
        imageView.image = UIImage(named: "noImage")
        imageView.backgroundColor = .white
        return imageView
    }()

    let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.textColor = .wtcOrange
        return label
    }()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 9
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .wtcYellow
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension DishCell {

    private func addSubviews() {
        mainStackView.addArrangedSubview(dishImageView)
        mainStackView.addArrangedSubview(dishDescriptionLabel)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            dishImageView.widthAnchor.constraint(equalToConstant: 50),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor, multiplier: 1),
            dishImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            dishDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dishDescriptionLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 6),
            dishDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
