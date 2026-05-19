//
//  NetworkingManager.swift
//  Cryptara
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case invalidURL
        case noConnection
        case timeout
        case httpError(Int)
        case decodingFailed
        case unauthorized(url: URL)
        case serverError
        case cancelled
        case badUrlResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL — typo or malformed address"
            case .noConnection:
                return "No internet — no delivery"
            case .timeout:
                return "Request took too long"
            case .httpError(let code):
                return "HTTP error \(code) from the server"
            case .decodingFailed:
                return "Decoding failed"
            case .unauthorized(let url):
                return "Session expired — refresh token. URL: \(url)"
            case .serverError:
                return "Server internal issue"
            case .cancelled:
                return "Request was cancelled"
            case .badUrlResponse(let url):
                return "Bad response from URL: \(url)"
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
           
                   case 200:
                       return output.data
                   case 201:
                       return output.data
                   case 204:
                       return output.data

                   case 301:
                       throw NetworkingError.httpError(301)
                   case 304:
                       throw NetworkingError.httpError(304)

                   case 400:
                       throw NetworkingError.httpError(400)
                   case 401:
                       throw NetworkingError.unauthorized(url: url)
                   case 403:
                       throw NetworkingError.httpError(403)
                   case 404:
                       throw NetworkingError.httpError(404)
                   case 409:
                       throw NetworkingError.httpError(409)
                   case 429:
                       throw NetworkingError.httpError(429)

                   
                   case 500:
                       throw NetworkingError.serverError

                  
                   case 200..<300:
                       return output.data
                   case 400..<500:
                       throw NetworkingError.httpError(response.statusCode)
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
