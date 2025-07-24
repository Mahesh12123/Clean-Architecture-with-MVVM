//
//  APIService.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 13/02/2025.
//

import Foundation
import Combine


class APIService {
    private let token: String
    

    init(token: String) {
        self.token = token
    }

    func request<T: Decodable>(endpoint: URL) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: endpoint)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("APILink == \(endpoint) and \(T.self)")
       
        return URLSession.shared.dataTaskPublisher(for: request)
        
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    
}
