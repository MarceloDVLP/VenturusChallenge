import Foundation

struct SearchResponse: Codable, Equatable {
    let data: [SearchResponseData]
    let success: Bool
    let status: Int    
}

struct SearchResponseData: Codable, Equatable {
    let id: String
    let title: String
    let images: [SearchResponseImage]
}

struct SearchResponseImage: Codable, Equatable {
    let id: String
    let title: String?
    let link: URL
    let type: String?
}

enum TypeContent: String, Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    case imageGIF
    case imageJPEG
    case imagePNG
    case videoMp4
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "imageGIF":
            self = .imageGIF
        case "imageJPEG":
            self = .imageJPEG
        case "imagePNG":
            self = .imagePNG
        case "videoMp4":
            self = .videoMp4
        default:
            fatalError("type not found")
        }
    }
}
