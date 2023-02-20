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
        photoView.showLoadingItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotoGalleryViewController: PhotoGalleryPresenterDelegate {

    func show(_ items: [Photo]) {
        hideErrorView()
        photoView.isHidden = false
        photoView.show(items)
    }
    
    func showTryAgain() {
        let errorView = PhotoGalleryViewError()
        errorView.pinView(in: view)
        photoView.isHidden = true
        
        errorView.didTapTryAgain = { [weak self] in
            self?.hideErrorView()
            self?.photoView.isHidden = false
            self?.presenter.didTapTryAgainButton()            
        }
    }
    
    private func hideErrorView() {
        let view = view.subviews.first(where: { type(of: $0) == PhotoGalleryViewError.self })
        view?.removeFromSuperview()
    }
}
