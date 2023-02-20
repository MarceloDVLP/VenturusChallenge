import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    private var presenter: PhotoGalleryPresenter
    
    private lazy var photoView: PhotoGalleryView = { return PhotoGalleryView() }()
    
    init(presenter: PhotoGalleryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoView()
        presenter.viewDidLoad()
    }
    
    func addPhotoView() {
        view.backgroundColor = .white
        photoView.pinView(in: view)        
        photoView.didSelect = { [weak self] item in
            self?.presenter.didSelectItem(item)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotoGalleryViewController: PhotoGalleryPresenterDelegate {

    func show(_ items: [Photo]) {
        photoView.show(items)
    }
}
