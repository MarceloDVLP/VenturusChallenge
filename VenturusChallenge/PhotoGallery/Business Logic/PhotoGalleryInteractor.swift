import Foundation


protocol PhotoGalleryInteractorProtocol {
    func fetchImages()
}

protocol PhotoGalleryInteractorDelegate {
    func show(_ items: [URL])
}


final class PhotoGalleryInteractor: PhotoGalleryInteractorProtocol {
    
    private var service: RemoteService
    
    var presenter: PhotoGalleryInteractorDelegate?
    
    init(service: RemoteService) {
        self.service = service
    }
    
    func fetchImages() {
        service.fetch(id: 0, completion: { [weak self] result in
            switch result {
            case .success(let response):
                
                var items: [URL] = []
                
                response.data.forEach({ data in
                    let urls = data.images.filter({ $0.type == "image/png" || $0.type == "image/jpeg" }).map({ $0.link })
                    items.append(contentsOf: urls)
                })
                
                self?.presenter?.show(items)
                
            case .failure(_):
                break
            }
        })
    }
}







final class PhotoGalleryViewControllerBuilder {
    
    static func make() -> PhotoGalleryViewController {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let clientHTTP = HTTPClient(session: session)
        let service = RemoteService(client: clientHTTP)
        let interactor = PhotoGalleryInteractor(service: service)

        let presenter = PhotoGalleryPresenter(interactor: interactor)
        interactor.presenter = presenter
        
        let viewController = PhotoGalleryViewController(presenter: presenter)
        presenter.viewController = viewController
        
        return viewController
    }
}
