//
//  APIClient.swift
//  MVVM+TableView
//
//  Created by ktrade on 2021/1/4.
//

import Foundation

enum NetWorkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpsMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpsMethod = .get
    var body: Data? = nil
}

protocol APIClientDelegate: AnyObject {
    func create<T>(url: String, vm: T) -> Resource<T?>
}

class APIClient {
    // Signleton
    static let shared = APIClient()
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetWorkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()

    }

    
}

extension APIClientDelegate {
    func create<T>(url: String, vm: T) -> Resource<T?> {
        
        guard let url = URL(string: url) else {
            fatalError("url error")
        }
        
        guard let data = try? JSONEncoder().encode(vm) else {
            fatalError("Error encoding data")
        }
        
        var resource = Resource<T?>(url: url)
        resource.httpMethod = HttpsMethod.post
        resource.body = data
        
        return resource
    }
}
