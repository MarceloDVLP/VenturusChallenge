import Foundation

protocol PhotoGalleryInteractorProtocol {
    func fetchImages()
}

protocol PhotoGalleryInteractorDelegate {
    func show(_ items: [Photo])
    func showTryAgain()
}

final class PhotoGalleryInteractor: PhotoGalleryInteractorProtocol {
    
    private var service: RemoteService
    
    var presenter: PhotoGalleryInteractorDelegate?
    
    var photos: [Photo] = []
    var page: Int = -1
    
    init(service: RemoteService) {
        self.service = service
    }
    
    func fetchImages() {
        page += 1
        service.fetch(page: page, completion: { [weak self] result in
            switch result {
            case .success(let response):
                
                var items: [Photo] = []
                
                response.data.forEach({ data in
                    let mapped = data.images?.filter({ $0.type == "image/png" || $0.type == "image/jpeg" }).map({ Photo(title: data.title, url: $0.link)}) ?? []
                    items.append(contentsOf: mapped)
                })
                self?.photos += items
                self?.presenter?.show(self?.photos ?? [])
                
            case .failure(_):
                if self?.page == 1 {
                    self?.presenter?.showTryAgain()
                }
            }
        })
    }
}
