import Foundation


protocol PhotoGalleryPresenterProtocol {
    func viewDidLoad()
}

protocol PhotoGalleryPresenterDelegate: AnyObject {
    func show(_ items: [URL])
}

final class PhotoGalleryPresenter: PhotoGalleryPresenterProtocol {
        
    private var interactor: PhotoGalleryInteractor
    
    weak var viewController: PhotoGalleryPresenterDelegate?
    
    init(interactor: PhotoGalleryInteractor) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.fetchImages()
    }
    
}

extension PhotoGalleryPresenter: PhotoGalleryInteractorDelegate {

    func show(_ items: [URL]) {
        viewController?.show(items)
    }
}
