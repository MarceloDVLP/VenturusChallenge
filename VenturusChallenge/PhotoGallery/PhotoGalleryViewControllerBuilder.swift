import UIKit

final class PhotoGalleryViewControllerBuilder {
    
    static func make() -> UIViewController {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let clientHTTP = HTTPClient(session: session)
        let service = RemoteService(client: clientHTTP)
        let interactor = PhotoGalleryInteractor(service: service)

        let router = PhotoGalleryRouter()
        
        let presenter = PhotoGalleryPresenter(interactor: interactor, router: router)
        interactor.presenter = presenter
        
        let viewController = PhotoGalleryViewController(presenter: presenter)
        presenter.viewController = viewController
        
        router.viewController = viewController
        
        return UINavigationController(rootViewController: viewController)
    }
}
