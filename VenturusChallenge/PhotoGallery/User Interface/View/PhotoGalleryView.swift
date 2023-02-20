import UIKit

enum Section {
    case main
}

final class PhotoGalleryView: UIView {

    typealias DataSource = UICollectionViewDiffableDataSource<Section, PhotoItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PhotoItem>

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: frame, collectionViewLayout: makeLayout())
    }()
    
    var items: [PhotoItem] = []
    
    var didSelect: ((PhotoItem) -> ())?
    
    private lazy var dataSource: DataSource = makeDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.pinView(in: self)
    }
    
    func cellRegistration() -> UICollectionView.CellRegistration<PhotoCell, PhotoItem> {
        return UICollectionView.CellRegistration<PhotoCell, PhotoItem> { (cell, indexPath, item) in
            
            cell.imageView.image = item.image
                                    
            _ = ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
                if let img = image, img != fetchedItem.image {
                    var updatedSnapshot = self.dataSource.snapshot()
                    if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
                        let item = self.items[datasourceIndex]
                        item.image = img
                        updatedSnapshot.reloadItems([item])
                        self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                    }
                }
            }
        }
    }
    
    func makeDataSource() -> DataSource {
        let cellRegistration = cellRegistration()
        
        return UICollectionViewDiffableDataSource<Section, PhotoItem>(collectionView: collectionView) {
            
            (collectionView: UICollectionView, indexPath: IndexPath, item: PhotoItem) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath, item: item)
        }
    }
    
    func show(_ items: [Photo]) {
        self.items = items.map({ PhotoItem(image: ImageCache.publicCache.placeholderImage, url: $0.url, title: $0.title) })

        applySnapshot(animatingDifferences: true)
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
                 
        return UICollectionViewCompositionalLayout(section: section)
    }
        
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension PhotoGalleryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        didSelect?(item)
    }
}


