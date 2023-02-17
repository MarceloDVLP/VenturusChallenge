import UIKit

final class PhotoGalleryView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        collectionView.backgroundColor = .blue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
            view.frame = bounds
            view.autoresizingMask = [
                UIView.AutoresizingMask.flexibleWidth,
                UIView.AutoresizingMask.flexibleHeight
            ]
            addSubview(view)
            self.view = view
    }
}
