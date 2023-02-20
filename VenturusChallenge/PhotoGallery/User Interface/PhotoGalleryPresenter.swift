import Foundation


protocol PhotoGalleryPresenterProtocol {
    func viewDidLoad()
    func didSelectItem(_ item: Item)
}

protocol PhotoGalleryPresenterDelegate: AnyObject {
    func show(_ items: [Photo])
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
    
    func didSelectItem(_ item: Item) {
        router.showDetail(item)
    }    
}

extension PhotoGalleryPresenter: PhotoGalleryInteractorDelegate {

    func show(_ items: [Photo]) {
        viewController?.show(items)
    }
}
