//
//  Networking.swift
//  NetworkingLayerExample
//
//  Created by Lorenzo Brown on 7/23/24.
//

import Foundation

protocol NetworkRequest {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case requestFailed
    case unknown
}

//struct DefaultRequest: NetworkRequest {
//    var url: URL
//    var method: HTTPMethod
//    var headers: [String: String]?
//    var body: Data?
//}

struct AssetsRequest: NetworkRequest {
    var url: URL { return URL(string: "https://api.coincap.io/v2/assets")! }
    var method: HTTPMethod { return .get }
    var headers: [String : String]? { return nil }
    var body: Data? { return nil }
}

class NetworkingLayer {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(_ request: NetworkRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("JSON DECODER FAILED", error)
                completion(.failure(.unknown))
            }
        }
        
        dataTask.resume()
    }
}
