//
//  NetworkingManager.swift
//  Cryptara
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError:LocalizedError {
        case badUrlResponse(url:URL)
        case unknown
        case unauthorized(url: URL)
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url):
                return "Bad response from URL: \(url)"
            case .unauthorized:
                return "Unauthorized - Invalid credentials"
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleUrlResponse(output: $0,url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.unknown
        }
        print("Status code: \(response.statusCode) for \(url)")
        
        switch response.statusCode {
        case 200..<300:
            return output.data
        case 400, 401:
            throw NetworkingError.unauthorized(url: url)
        default:
            throw NetworkingError.badUrlResponse(url: url)
        }
    }
    
    static func postMethod<T: Encodable>(url: URL, body: T,headers: [String: String]? = nil ) -> AnyPublisher<Data, Error> {
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(StringConstants.HttpMethod.post)"
        request.setValue("\(StringConstants.NetworkingManagerConst.appJson)", forHTTPHeaderField: "\(StringConstants.NetworkingManagerConst.ContentType)")
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
    }
    
    static func getMethod(url: URL, headers: [String: String]? = nil) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "\(StringConstants.HttpMethod.get)"
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}
