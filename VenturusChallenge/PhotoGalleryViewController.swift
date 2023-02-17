import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    init() {        
        super.init(nibName: nil, bundle: nil)
        view = PhotoGalleryView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
