import UIKit

final class PhotoCell: UICollectionViewCell {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var task: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.pinView(in: self)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
//        task?.cancel()
//        task = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func configure(with item: PhotoItem) {
        self.task = ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
            self.imageView.image = image
        }        
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
