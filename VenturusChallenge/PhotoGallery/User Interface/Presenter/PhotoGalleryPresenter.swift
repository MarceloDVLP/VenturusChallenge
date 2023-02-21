import Foundation


protocol PhotoGalleryPresenterProtocol {
    func viewDidLoad()
    func didSelectItem(_ item: PhotoItem)
    func didTapTryAgainButton()
}

protocol PhotoGalleryPresenterDelegate: AnyObject {
    func show(_ items: [Photo])
    func showTryAgain()
}

final class PhotoGalleryPresenter: PhotoGalleryPresenterProtocol {
        
    private var interactor: PhotoGalleryInteractor
    private var router: PhotoGalleryRouter
    weak var viewController: PhotoGalleryPresenterDelegate?
    
    init(interactor: PhotoGalleryInteractor, router: PhotoGalleryRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchImages()
    }
    
    func didSelectItem(_ item: PhotoItem) {
        router.showDetail(item)
    }
    
    func didTapTryAgainButton() {
        interactor.fetchImages()
    }
    
    func didScrollToTheEnd() {
        interactor.fetchImages()
    }
}

extension PhotoGalleryPresenter: PhotoGalleryInteractorDelegate {

    func show(_ items: [Photo]) {
        viewController?.show(items)
    }
    
    func showTryAgain() {
        viewController?.showTryAgain()
    }
}
