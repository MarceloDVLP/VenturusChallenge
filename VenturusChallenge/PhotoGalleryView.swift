import UIKit

final class PhotoGalleryView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var response: SearchResponse?
    var service: RemoteService!
    var items: [Item] = []
    
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
                
                self.response?.data.forEach({ data in
                    let urls = data.images.filter({ $0.type == "image/png" || $0.type == "image/jpeg" }).map({ $0.link })
                    let items = urls.map({ Item(image: ImageCache.publicCache.placeholderImage, url: $0) })
                    self.items.append(contentsOf: items)
                })
                
                self.collectionView.reloadData()
                
            case .failure(_):
                break
            }
        })
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let inset: CGFloat = 2.5
        
        // Items
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Nested Group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
        
        // Outer Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
         
        section.orthogonalScrollingBehavior = .none
        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension PhotoGalleryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        let item = items[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

extension PhotoGalleryView: UICollectionViewDelegate {
    
}



