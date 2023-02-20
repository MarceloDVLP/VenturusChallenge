import Foundation


protocol PhotoGalleryInteractorProtocol {
    func fetchImages()
}

protocol PhotoGalleryInteractorDelegate {
    func show(_ items: [Photo])
}

struct Photo {
    let title: String?
    let url: URL
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
                
                var items: [Photo] = []
                
                response.data.forEach({ data in
                    let photos = data.images.filter({ $0.type == "image/png" || $0.type == "image/jpeg" }).map({ Photo(title: data.title, url: $0.link)})
                    items.append(contentsOf: photos)
                })
                
                self?.presenter?.show(items)
                
            case .failure(_):
                break
            }
        })
    }
}