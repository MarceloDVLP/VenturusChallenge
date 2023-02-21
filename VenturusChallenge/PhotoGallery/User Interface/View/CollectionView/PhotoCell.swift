import UIKit

final class PhotoCell: UICollectionViewCell {

    var updateCell: ((PhotoItem, UIImage) -> ())?
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.pinView(in: self)
        clipsToBounds = true
        backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func load(with item: PhotoItem) {
        if item.image == nil {
            startShimmeringEffect()
        } else {
            stopShimmeringEffect()
        }

        imageView.image = item.image

        guard let url = item.url else { return }
        
        _ = ImageCache.publicCache.load(url: url as NSURL, item: item) { [weak self] (fetchedItem, image) in
            if let img = image, img != fetchedItem.image {
                self?.updateCell?(fetchedItem, img)
            }
        }
    }
}
