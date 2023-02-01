import UIKit

// MARK: - ImageCell
final class ImageCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.wtcRed.cgColor
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "noImage")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .wtcYellow
        addSubview(dishImageView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension ImageCell {

    private func setupConstraints() {
        let constraints = [
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor, multiplier: 1),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            dishImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
