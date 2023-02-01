import UIKit

// MARK: - MenuViewDelegate protocol
protocol MenuViewDelegate: AnyObject {
    func proceedToDishesList()
}

// MARK: - MenuView
final class MenuView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: MenuViewDelegate?

    let infoLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.text = "Select a dish main category:"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .wtcRed
        return label
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.color = .wtcOrange
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    let dishPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.toAutolayout()
        return pickerView
    }()

    let goButton: UIButton = {
        let button = UIButton()
        button.toAutolayout()
        button.setTitle("Go!", for: .normal)
        button.backgroundColor = .wtcOrange
        button.titleLabel?.textColor = .wtcRed
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 50
        button.layer.borderColor = UIColor.wtcRed.cgColor
        button.layer.borderWidth = 5
        button.addTarget(nil, action: #selector(goTapped), for: .touchUpInside)
        return button
    }()

    private lazy var linkTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "This app was made, using www.themealdb.com API")
        attributedString.addAttribute(.link, value: "https://www.themealdb.com",
                                      range: NSRange(location: 25, length: 17))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .clear
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
        backgroundColor = .wtcYellow
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension MenuView {

    @objc private func goTapped() {
        delegate?.proceedToDishesList()
    }

    private func addSubviews() {
        addSubview(infoLabel)
        addSubview(dishPicker)
        addSubview(activityIndicator)
        addSubview(goButton)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            dishPicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            dishPicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            infoLabel.bottomAnchor.constraint(equalTo: dishPicker.topAnchor, constant: -12),
            goButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goButton.topAnchor.constraint(equalTo: dishPicker.bottomAnchor, constant: 12),
            goButton.widthAnchor.constraint(equalToConstant: 100),
            goButton.heightAnchor.constraint(equalTo: goButton.widthAnchor, multiplier: 1),
            linkTextView.heightAnchor.constraint(equalToConstant: 24),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
