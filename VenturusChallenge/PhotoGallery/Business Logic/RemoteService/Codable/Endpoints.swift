import Foundation

struct Endpoints {
            
    static func url(_ page: Int) -> URL {
        return URL(string: "https://api.imgur.com/3/gallery/search/?q=cats&page=\(page)")!
    }
}
