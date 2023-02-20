import Foundation

protocol RemoteServiceProtocol {
    func fetch(completion: @escaping (ServiceResult) -> ())
}

typealias ServiceResult = Result<SearchResponse, RemoteServiceError>

final class RemoteService: RemoteServiceProtocol {
    
    private var client: HTTPClientProtocol
    
    init(client: HTTPClientProtocol) {
        self.client = client
    }

    func fetch(completion: @escaping (ServiceResult) -> ()) {
        let url = Endpoints.url

        client.request(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let decoded = self.decode(data)
                completion(decoded)
            case .failure(_):
                completion(.failure(.serverError))
            }
        })
    }
        
    private func decode(_ data: Data) -> ServiceResult {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(SearchResponse.self, from: data)
            return Result.success(object)
        } catch let error {
            print("Error to DECODE: \(String(describing: error))")
            return Result.failure(RemoteServiceError.serverError)
        }
    }
}

enum RemoteServiceError: Error, Equatable {
    case serverError
}
