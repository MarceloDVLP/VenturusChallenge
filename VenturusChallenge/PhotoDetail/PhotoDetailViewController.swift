import UIKit

final class PhotoDetailViewController: UIViewController {

    private var item: PhotoItem
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(_ item: PhotoItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        constraintImageView()
        constraintNameLabel()
        view.backgroundColor = .white
        nameLabel.text = item.title

        guard let url = item.url as? NSURL else { return }
        
        let image = ImageCache.publicCache.image(url: url)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9/16)
        ])
    }

    func constraintNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16)
        ])
    }
}
