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
        photoView.didSelect = { [weak self] item in
            self?.presenter.didSelectItem(item)
        }
    }
    
    func addPhotoView() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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


final class PhotoGalleryRouter {
    
    weak var viewController: PhotoGalleryViewController?
    
    func showDetail(_ item: Item) {
        let detailViewController = PhotoDetailViewController(item)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
