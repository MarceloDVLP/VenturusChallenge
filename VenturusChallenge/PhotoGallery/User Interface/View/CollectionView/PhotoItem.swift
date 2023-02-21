import UIKit

class PhotoItem: Hashable {

    var url: URL?
    let identifier = UUID()
    var image: UIImage?
    var title: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(image: UIImage? = nil, url: URL? = nil, title: String? = nil) {
        self.image = image
        self.url = url
        self.title = title
    }
}

final class PhotoLoading: PhotoItem {}
