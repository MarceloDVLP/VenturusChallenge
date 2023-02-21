import UIKit

final class PhotoGalleryViewError: UIView {
    
    var didTapTryAgain: (() -> ())?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Try Again", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Sorry, we could not load the images :("
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintButton()
        constraintTextLabel()
        backgroundColor = .white
    }
    
    @objc func didTapButton() {
        didTapTryAgain?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func constraintTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
