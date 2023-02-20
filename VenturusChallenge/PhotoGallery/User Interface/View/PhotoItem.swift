import UIKit

final class PhotoItem: Hashable {

    let url: URL
    let identifier = UUID()
    var image: UIImage
    var title: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(image: UIImage, url: URL, title: String?) {
        self.image = image
        self.url = url
        self.title = title
    }
}
