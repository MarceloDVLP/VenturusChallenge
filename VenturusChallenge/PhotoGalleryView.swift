import UIKit

final class PhotoGalleryView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var response: SearchResponse?
    var service: RemoteService!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        fetchData()
        collectionView.collectionViewLayout = makeLayout()
        let nib = UINib(nibName: PhotoCell.reuseIdentifier, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier) //(PhotoCell.self,
    }
    
    func loadViewFromNib() {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
            view.frame = bounds
            view.autoresizingMask = [
                UIView.AutoresizingMask.flexibleWidth,
                UIView.AutoresizingMask.flexibleHeight
            ]
            addSubview(view)
            self.view = view
    }
    
    func fetchData() {
        service = RemoteService(client: HTTPClient(session: URLSession.shared))
        service.fetch(id: 0, completion: { result in
            switch result {
            case .success(let response):
                self.response = response
            case .failure(_):
                break
            }
        })
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1/3

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let inset: CGFloat = 4
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension PhotoGalleryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
}

extension PhotoGalleryView: UICollectionViewDelegate {
    
}



