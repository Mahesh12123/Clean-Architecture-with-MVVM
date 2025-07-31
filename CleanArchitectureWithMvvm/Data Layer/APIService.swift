//
//  APIService.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 13/02/2025.
//

import Foundation
import Combine


enum APIError: LocalizedError {
    case invalidURL
    case requestFailed(Int) // status code
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let code):
            return "Request failed with status code: \(code)"
        case .decodingError:
            return "Failed to decode response"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

class APIService {
    private let token: String
    

    init(token: String) {
        self.token = token
    }

    func request<T: Decodable>(endpoint: URL) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: endpoint)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        print("APILink == \(endpoint) and \(T.self)")
        
        
        return URLSession.shared.dataTaskPublisher(for: request)
                
        
            .tryMap { data, response in
                       // Basic error handling for HTTP status codes
                       guard let httpResponse = response as? HTTPURLResponse,
                             (200...299).contains(httpResponse.statusCode) else {
                           print("httpResponse.statusCode == \(response)")
                           throw URLError(.badServerResponse)
                       }
                       return data
                   }
        
           // .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { data in
                print("✅ Received API response for: \(data)")
            }, receiveCompletion: { completion in
                print("📦 Completion: \(completion)")
            })
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if error is DecodingError {
                    return APIError.decodingError
                } else {
                    return APIError.unknown(error)
                }
            }
        
            .eraseToAnyPublisher()
        
//            .tryMap { output in
//                let response = output.response as? HTTPURLResponse
//                let statusCode = response?.statusCode ?? -1
//                print("statusCode: \(statusCode)")
//                
//                if !(200...299).contains(statusCode) {
//                    throw APIError.requestFailed(statusCode)
//                }
//                
//                return output.data
//            }
//            .handleEvents(receiveOutput: { data in
//                print("✅ Received API response for: \(data)")
//            }, receiveCompletion: { completion in
//                print("📦 Completion: \(completion)")
//            })
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { error in
//                if let apiError = error as? APIError {
//                    return apiError
//                } else if error is DecodingError {
//                    return APIError.decodingError
//                } else {
//                    return APIError.unknown(error)
//                }
//            }
//            .eraseToAnyPublisher()
        
        
    }
    
    
}
