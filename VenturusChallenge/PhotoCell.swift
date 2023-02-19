import UIKit

final class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var task: URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        task?.cancel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func configure(with item: Item) {
        ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
            self.imageView.image = image
            if let img = image, img != fetchedItem.image {
//                var updatedSnapshot = self.dataSource.snapshot()
//                if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
//                    let item = self.imageObjects[datasourceIndex]
//                    item.image = img
//                    updatedSnapshot.reloadItems([item])
//                    self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
//                }
            }
        }
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
