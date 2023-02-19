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
        photoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presenter.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotoGalleryViewController: PhotoGalleryPresenterDelegate {

    func show(_ items: [URL]) {
        photoView.show(items)
    }
}
