import UIKit

// MARK: - NameCell
final class NameCell: UITableViewCell {

    // MARK: - Properties and Initializers
    lazy var dishNameLabel = makeLabel(withTextSize: 24, andWeight: .bold)

    lazy var dishAreaLabel = makeLabel()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
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
extension NameCell {

    private func addSubviews() {
        mainStackView.addArrangedSubview(dishNameLabel)
        mainStackView.addArrangedSubview(dishAreaLabel)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withTextSize size: CGFloat = 18, andWeight weight: UIFont.Weight = .regular) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .wtcRed
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        return label
    }
}
