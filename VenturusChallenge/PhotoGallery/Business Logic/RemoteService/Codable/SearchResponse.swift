import Foundation

struct SearchResponse: Codable, Equatable {
    let data: [SearchResponseData]
    let success: Bool
    let status: Int    
}

struct SearchResponseData: Codable, Equatable {
    let id: String
    let title: String
    let images: [SearchResponseImage]?
}

struct SearchResponseImage: Codable, Equatable {
    let id: String
    let title: String?
    let link: URL
    let type: String?
}
